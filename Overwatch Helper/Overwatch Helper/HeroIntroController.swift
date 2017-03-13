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

var heroArray:[HeroIntroInfo] = []


class HeroIntroController: UITableViewController {

    static let numberOfHeros = 7
    
    
    var lastSelected:Int?
    var CELLCOUNT = numberOfHeros //change
    
    //------when make change on your cell size, also modify these------
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 165
            static let open: CGFloat = 530
            
        }
    }
    
    let kCloseCellHeight:CGFloat = 165
    let kOpenCellHeight:CGFloat = 430
    //------------------------------------------------------------------
    
    
    //cell count may vary
    var cellHeights = (0..<numberOfHeros).map { _ in C.CellHeight.close } //change2
    
    //Views
    //@IBOutlet weak var moreView: UIView!
    //@IBOutlet var recognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, 
//        typically from a nib.
        //recognizer.addTarget(self, action: #selector(handleMoreInfoButtonTapped))
        //recognizer.numberOfTapsRequired = 1;
        //moreView.addGestureRecognizer(recognizer)
        //moreView.isUserInteractionEnabled = true;
        
        initializeTable()
        
        self.clearsSelectionOnViewWillAppear = false
        //self.tableView.selected
    }
    
    
    static func initializeHeros()
    {
        let path = Bundle.main.path(forResource: "HeroIntroData", ofType: "plist")
        let dataWithPath =  NSDictionary(contentsOfFile: path!)
        guard let data = dataWithPath
            else
        {
            return
        }
        
        let keys = data.allKeys as! [String]
        
        
        var tempArray:[HeroIntroInfo] = []
        
        for i in 0..<keys.count
        {
            if (keys[i] == "ProtoType")
            {
                continue
            }
            
            let basicInfo = data.value(forKey: keys[i]) as! NSDictionary
            //print(basicInfo.value(forKey: "name")!)
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
            
            let proto = HeroIntroInfo.init(name: basicInfo.value(forKey: "name") as! String, image: UIImage.init(named: "\(basicInfo.value(forKey: "image") as! String)")!, diff: basicInfo.value(forKey: "diff") as! Int, type: type, id: basicInfo.value(forKey: "id") as! Int, url: basicInfo.value(forKey: "url") as! String)
            
            //print(proto.heroName)
            
            let abilityArray = basicInfo.value(forKey: "HeroAbility") as! NSArray
            
            for j in 0..<abilityArray.count
            {
                let oneAbility = abilityArray[j] as! NSDictionary
                proto.setHeroAblity(des: oneAbility.value(forKey: "des") as! String, name: oneAbility.value(forKey: "name") as! String, img: UIImage(named: oneAbility.value(forKey: "img") as! String)!)
            }
            
            tempArray.append(proto)
            
            
        }
        
        /*
         let lucio = HeroIntroInfo.init(name: "Lucio", image: UIImage.init(named: "Hero-Lucio")!, diff: 2, type: HeroType.Support,id: 7, url:"ywTNgR3ldFc")
         
         lucio.setHeroAblity(des: "Lúcio can hit his enemies with sonic projectiles or knock them back with a blast of sound.", name: "Sonic Amplifier",img:UIImage(named: "Lucio-SA")!)
         lucio.setHeroAblity(des: "Lúcio continuously energizes himself, and nearby teammates, with music. He can switch between two songs: one amplifies movement speed, while the other regenerates health.", name: "Crossfade",img:UIImage(named: "Lucio-C")!)
         lucio.setHeroAblity(des: "Lúcio increases the volume on his speakers, boosting the effects of his songs.", name: "Amp It Up",img:UIImage(named: "Lucio-AIU")!)
         
         lucio.setHeroAblity(des: "Protective waves radiate out from Lúcio’s Sonic Amplifier, briefly providing him and nearby allies with personal shields.", name: "Sound Barrier",img:UIImage(named: "Lucio-SB")!)
         
         /*
         lucio.setHeroAblity(des: "Lúcio rides along a wall. This has a slight upwards angle, allowing him to ascend the wall.", name: "Wall Ride") */
         
         let Sodier76 = HeroIntroInfo.init(name: "Sodier76", image: UIImage.init(named: "Hero-76")!, diff: 1, type: HeroType.Offense,id: 15, url:"V_0eqEbG7yA")
         
         Sodier76.setHeroAblity(des: "Soldier: 76’s rifle remains particularly steady while unloading fully-automatic pulse fire. He can also fire single shots with pinpoint accuracy.", name: "Heavy Pulse Rifle",img:UIImage(named: "76-HPR")!)
         Sodier76.setHeroAblity(des: "Tiny rockets spiral out of Soldier: 76’s Pulse Rifle in a single burst. The rockets’ explosion damages enemies in a small radius.", name: "Helix Rockets",img:UIImage(named: "76-HR")!)
         Sodier76.setHeroAblity(des: "Whether he needs to evade a firefight or get back into one, Soldier: 76 can rush ahead in a burst of speed. His sprint ends if he takes an action other than charging forward.",name: "Sprint",img:UIImage(named: "76-S")!)
         Sodier76.setHeroAblity(des: "Soldier: 76 plants a biotic emitter on the ground. Its energy projection restores health to 76 and any of his squadmates within the field.", name: "Biotic Field",img:UIImage(named: "76-BF")!)
         Sodier76.setHeroAblity(des: "Soldier: 76’s pinpoint targeting visor “locks” his aim on the threat closest to his crosshairs. If an enemy leaves his line of sight, Soldier: 76 can quickly switch to another target.", name: "Tactical Visor",img:UIImage(named: "76-TV")!)
         
         
         let Genji = HeroIntroInfo.init(name: "Genji", image: UIImage.init(named: "Hero-Genji")!, diff: 3, type: HeroType.Offense,id: 4,url:"lYOjIDhJIG0")
         Genji.setHeroAblity(des: "Genji looses three deadly throwing stars in quick succession. Alternatively, he can throw three shuriken in a wider spread.", name: "Shuriken", img:UIImage(named: "Genji-Shuriken")!)
         Genji.setHeroAblity(des: "Genji darts forward, slashing with his katana and passing through foes in his path. If Genji eliminates a target, he can instantly use this ability again.", name: "Swift Strike",img:UIImage(named: "Genji-SS")!)
         Genji.setHeroAblity(des: "With lightning-quick swipes of his sword, Genji reflects any oncoming projectiles and can send them rebounding towards his enemies.",name: "Deflect",img:UIImage(named: "Genji-Deflect")!)
         Genji.setHeroAblity(des: "Thanks to his cybernetic abilities, Genji can climb walls and perform jumps in mid-air.", name: "Cyber-Agility",img:UIImage(named: "Genji-CA")!)
         Genji.setHeroAblity(des: "Genji brandishes his katana for a brief period of time. Until he sheathes his sword, Genji can deliver killing strikes to any targets within his reach.", name: "Dragonblade",img:UIImage(named: "Genji-Dragonblade")!)
         
         
         
         let Mcree = HeroIntroInfo.init(name: "Mcree", image: UIImage.init(named: "Hero-Mcree")!, diff: 3, type: HeroType.Offense,id: 8,url:"kq4OlEDiCi8")
         
         Mcree.setHeroAblity(des: "McCree fires off a round from his trusty six-shooter.", name: "Peacekeeper",img: UIImage(named: "Mcree-P")!)
         Mcree.setHeroAblity(des: "McCree dives in the direction he's moving, effortlessly reloading his Peacekeeper in the process.", name: "Combat Roll",img: UIImage(named: "Mcree-CR")!)
         Mcree.setHeroAblity(des: "McCree heaves a blinding grenade that explodes shortly after it leaves his hand. The blast staggers enemies in a small radius.", name: "Flashbang",img: UIImage(named: "Mcree-F")!)
         Mcree.setHeroAblity(des: "Focus. Mark. Draw. McCree takes a few precious moments to aim; when he's ready to fire, he shoots every enemy in his line of sight. The weaker his targets are, the faster he'll line up a killshot.", name: "Deadeye",img:UIImage(named: "Mcree-D")!)
         
         
         
         
         tempArray.append(lucio)
         tempArray.append(Sodier76)
         tempArray.append(Genji)
         tempArray.append(Mcree)
         */
        
        
        heroArray = tempArray
    }
    
    /** **/
    func initializeTable()
    {
        //CELLCOUNT = heroArray.count
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
        // Configure the cell...
        let foreImage = cell.foregroundView.subviews[0] as! UIImageView
        foreImage.image = heroArray[indexPath.row].topImage
        foreImage.layer.cornerRadius = (foreImage.frame.height)/2
        foreImage.clipsToBounds = true
        cell.foregroundView.backgroundColor = UIColor(patternImage: UIImage(named: "Hero-Bg")!)
        //print(cell.containerView.subviews.count)
        //print(cell.containerView.subviews[0].subviews.count)
        let backImage = cell.containerView.subviews[0].subviews[0] as! UIImageView
        backImage.image = heroArray[indexPath.row].topImage
        backImage.layer.cornerRadius = (backImage.frame.height)/2
        backImage.clipsToBounds = true
        cell.containerView.subviews[0].backgroundColor = UIColor(patternImage: UIImage(named: "Hero-Bg")!)
        //backImage.image = heroArray[indexPath.row].topImage
        //let btnView = cell.contentView.viewWithTag(1)?.subviews[0] as! UIButton
        //let recognizer = UITapGestureRecognizer()
        //recognizer.addTarget(self, action: #selector(handleMoreInfoButtonTapped))
        //recognizer.numberOfTapsRequired = 1;
        //btnView.addGestureRecognizer(recognizer)
        //btnView.addTarget(self, action: #selector(self.handleMoreInfoButtonTapped(_:)), for: .touchDown)
        //btnView.isUserInteractionEnabled = true;
        let heroTpye = cell.containerView.subviews[1].subviews[1] as! UILabel
        heroTpye.text = "\(heroArray[indexPath.row].heroType)"
        let diffImage = cell.containerView.subviews[1].subviews[3] as! UIImageView
        //var str = "\(heroArray[indexPath.row].difficulty)stars"
        diffImage.image = UIImage(named: "\(heroArray[indexPath.row].difficulty)stars")
        //set labels and images
//        cell.heroDetailContent.text = "123455"
//        cell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        //for Folding Cell:
        //cell.selectedAnimation(true, animated: true, completion: nil) is set space
        //Is displaying the expanding animation
        //tableView.beginUpdates()
        //tableView.endUpdates()
        //is the real expanding the view
        /*
        if let lastSelected = lastSelected
        {
            let lastIndexPath = IndexPath(row: lastSelected, section: 0)
            print(self.tableView.numberOfRows(inSection: 0))
            guard case let lastCell as FoldingCell = tableView.cellForRow(at: lastIndexPath) else {
                return
            }
            print(1)
            if (self.cellHeights[lastIndexPath.row] == self.kOpenCellHeight && lastIndexPath != indexPath) //last is open
            {
                cellHeights[lastIndexPath.row] = kCloseCellHeight
                lastCell.selectedAnimation(false, animated: true, completion: nil)
                let duration = 1.1
                
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }, completion: {
                    
                    (response) in
                    print(2)
                    var duration = 0.0
                    if self.cellHeights[indexPath.row] == self.kCloseCellHeight { // open cell
                        self.cellHeights[indexPath.row] = self.kOpenCellHeight
                        cell.selectedAnimation(true, animated: true, completion: nil)
                        duration = 0.5
                    } else {// close cell
                        self.cellHeights[indexPath.row] = self.kCloseCellHeight
                        cell.selectedAnimation(false, animated: true, completion: nil)
                        duration = 1.1
                    }
                    
                    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
                        tableView.beginUpdates()
                        tableView.endUpdates()
                    }, completion: {
                        (Result) in
                        print(3)
                        self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                        //self.lastSelected = indexPath.row
                    })
                    
                    
                })
            }
 
            //else
            //{
            //    print(4)
                var duration = 0.0
                if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
                    cellHeights[indexPath.row] = kOpenCellHeight
                    cell.selectedAnimation(true, animated: true, completion: nil)
                    duration = 0.5
                } else {// close cell
                    cellHeights[indexPath.row] = kCloseCellHeight
                    cell.selectedAnimation(false, animated: true, completion: nil)
                    duration = 1.1
                }
                
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }, completion: {
                    (Result) in
                    self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                    //self.lastSelected = indexPath.row
                })
                
            //}
 
            
        }
         */
        //else
        //{
            var duration = 0.0
            var type = 0
            if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
                type = 0
                cellHeights[indexPath.row] = kOpenCellHeight
                cell.selectedAnimation(true, animated: true, completion: nil)
                duration = 0.5
            } else {// close cell
                type = 1
                cellHeights[indexPath.row] = kCloseCellHeight
                cell.selectedAnimation(false, animated: true, completion: nil)
                duration = 1.1
            }
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
                tableView.beginUpdates()
                tableView.endUpdates()
            }, completion: {
                (Result) in
                if (type == 0)
                {
                    self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                }
                //self.lastSelected = indexPath.row
            })
       // }
       // self.lastSelected = indexPath.row
    }
    
    /*
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselect:\(indexPath.row)")
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        cellHeights[indexPath.row] = kCloseCellHeight
        cell.selectedAnimation(false, animated: true, completion: nil)
        var duration = 1.1
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)

    }
    */
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if case let cell as FoldingCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueHeroDetail"
        {
            //if not in wifi connection, pop a reminder
            if currentReachability != .reachableViaWiFi {
                
                let alert = UIAlertController(title: "This page contains video", message: "Better to watch under Wi-Fi connection", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                })
                alert.addAction(action)
            }
            
//            print(self.tableView.)
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let hero = heroArray[indexPath.row]
                let controller = segue.destination as! HeroDetailController
                controller.detailItem = hero
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    

}
extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
