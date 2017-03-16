//
//  ViewController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import FoldingCell
import YouTubePlayer_Swift


/// Array that saved hero information, global
var heroArray:[HeroIntroInfo] = []


/// Define the Hero Introduction View Controller
class HeroIntroController: UITableViewController {

    /// Define Number of Heros in the app
    static let numberOfHeros = 7
    
    
    //var lastSelected:Int?
    
    //var CELLCOUNT = numberOfHeros //change
    
    //------when make change on your cell size, also modify these------
    
    /// Define the Cell height structure, it is used for folding cell.
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 165
            static let open: CGFloat = 530
            
        }
    }
    
    
    /// Defining close cell height
    let kCloseCellHeight:CGFloat = 165
    
    
    /// Defining open cell height
    let kOpenCellHeight:CGFloat = 430
    //------------------------------------------------------------------
    
    
    
    /// Initialize cell heights
    var cellHeights = (0..<numberOfHeros).map { _ in C.CellHeight.close } //change2
    
    //Views
    //@IBOutlet weak var moreView: UIView!
    //@IBOutlet var recognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTable() //inialize table
        
        self.clearsSelectionOnViewWillAppear = false //do not deselect cell on appear
        //self.tableView.selected
    }
    
    
    /// Initialize Hero in the very beginning of the program. Used for once only
    static func initializeHeros()
    {
        NSLog("Initializing Hero Data, Reading From HeroIntroData.plist")
        
        let path = Bundle.main.path(forResource: "HeroIntroData", ofType: "plist")
        let dataWithPath =  NSDictionary(contentsOfFile: path!)
        guard let data = dataWithPath
            else
        {
            return
        }
        NSLog("Path for Hero Data:\(path)")
        
        
        let keys = data.allKeys as! [String] //get all keys in hero data
        
        
        var tempArray:[HeroIntroInfo] = [] //temp array for saving data
        
        for i in 0..<keys.count
        {
            if (keys[i] == "ProtoType") //if prototype, skip
            {
                continue
            }
            
            let basicInfo = data.value(forKey: keys[i]) as! NSDictionary //create basic infomation
            //print(basicInfo.value(forKey: "name")!)
            
            //tranferring basic hero types
            var type = HeroType.NotDefined
            if ((basicInfo.value(forKey: "type") as! String) == "Offense")
            {
                type = HeroType.Offense
            }
            else if ((basicInfo.value(forKey: "type") as! String) == "Defense")
            {
                type = HeroType.Defense
            }
            else if ((basicInfo.value(forKey: "type") as! String) == "Support")
            {
                type = HeroType.Support
            }
            else if ((basicInfo.value(forKey: "type") as! String) == "Tank")
            {
                type = HeroType.Tank
            }
            
            //create the object that contains basic hero info
            let proto = HeroIntroInfo.init(name: basicInfo.value(forKey: "name") as! String, image: UIImage.init(named: "\(basicInfo.value(forKey: "image") as! String)")!, diff: basicInfo.value(forKey: "diff") as! Int, type: type, id: basicInfo.value(forKey: "id") as! Int, url: basicInfo.value(forKey: "url") as! String)
            
            //print(proto.heroName)
            //Create an object that holds hero abilities.
            let abilityArray = basicInfo.value(forKey: "HeroAbility") as! NSArray
            
            for j in 0..<abilityArray.count
            {
                let oneAbility = abilityArray[j] as! NSDictionary
                proto.setHeroAblity(des: oneAbility.value(forKey: "des") as! String, name: oneAbility.value(forKey: "name") as! String, img: UIImage(named: oneAbility.value(forKey: "img") as! String)!)
            }
            
            tempArray.append(proto)//append
            
        }
        
        heroArray = tempArray //set heroArray
    }
    
    
    /// After Hero is loaded, reload tableview
    func initializeTable()
    {
        self.tableView.reloadData()
    }
    
    

    /*
    @IBAction func handleMoreInfoButtonTapped(_ sender: Any){
        print("tapped!")
        //performSegue(withIdentifier: "SegueHeroDetail", sender: sender)
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! HeroCell
        
        // Configure the cell. Set ForeImage
        let foreImage = cell.foregroundView.subviews[0] as! UIImageView
        foreImage.image = heroArray[indexPath.row].topImage
        foreImage.layer.cornerRadius = (foreImage.frame.height)/2
        foreImage.clipsToBounds = true
        cell.foregroundView.backgroundColor = UIColor(patternImage: UIImage(named: "Hero-Bg")!)
        
        
        // Set Back Image
        let backImage = cell.containerView.subviews[0].subviews[0] as! UIImageView
        backImage.image = heroArray[indexPath.row].topImage
        backImage.layer.cornerRadius = (backImage.frame.height)/2
        backImage.clipsToBounds = true
        cell.containerView.subviews[0].backgroundColor = UIColor(patternImage: UIImage(named: "Hero-Bg")!)
        
        
        //Set Hero Type
        let heroTpye = cell.containerView.subviews[1].subviews[1] as! UILabel
        heroTpye.text = "\(heroArray[indexPath.row].heroType)"
        
        //Set diffculty image
        let diffImage = cell.containerView.subviews[1].subviews[3] as! UIImageView
        //var str = "\(heroArray[indexPath.row].difficulty)stars"
        diffImage.image = UIImage(named: "\(heroArray[indexPath.row].difficulty)stars")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
            var duration = 0.0 //set duration
            var type = 0 //present close operation or open operation
        
            if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
                type = 0
                cellHeights[indexPath.row] = kOpenCellHeight //set height
                cell.selectedAnimation(true, animated: true, completion: nil) //perform the animation (but not expand the cell here)
                duration = 0.5
            } else {// close cell
                type = 1
                cellHeights[indexPath.row] = kCloseCellHeight //set height
                cell.selectedAnimation(false, animated: true, completion: nil)
                duration = 1.1
            }
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
                tableView.beginUpdates() //Expand the cell
                tableView.endUpdates() //Expand the cell
            }, completion: {
                (Result) in
                if (type == 0) //if open
                {
                    self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true) //set the selected cell to middle
                }
            })
    }
    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if case let cell as FoldingCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close { //close cell
                cell.selectedAnimation(false, animated: false, completion:nil) // no animation
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil) //open cell
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueHeroDetail"
        {
            NSLog("Segue Triggered, to Hero Detail")
            
            if currentReachability != .reachableViaWiFi {
                //If not reachable via wifi, perform alert
                let message = (currentReachability == .reachableViaWWAN ? "Better to watch under Wi-Fi connection" : "Internet connection required")
                let alert = UIAlertController(title: "This page contains video", message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                })
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: {})
                }
            }
            
//
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //get the selected
                
                //path the data to detail view.
                let hero = heroArray[indexPath.row]
                let controller = segue.destination as! HeroDetailController
                controller.detailItem = hero
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}


// MARK: - Trim a string
extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
