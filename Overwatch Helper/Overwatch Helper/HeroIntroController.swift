//
//  ViewController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import FoldingCell

class HeroIntroController: UITableViewController {

    var heroArray:[HeroIntroInfo] = []
    
    var CELLCOUNT = 1
    
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
    var cellHeights = (0..<4).map { _ in C.CellHeight.close }
    
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
        initializeHeros()
    }
    
    /** **/
    func initializeHeros()
    {
        var tempArray:[HeroIntroInfo] = []
        
        let lucio = HeroIntroInfo.init(name: "Lucio", image: UIImage.init(named: "Hero-Lucio")!, diff: 2, type: HeroType.Support,id: 7)
        let Sodier76 = HeroIntroInfo.init(name: "Sodier76", image: UIImage.init(named: "Hero-76")!, diff: 1, type: HeroType.Offense,id: 15)
        let Genji = HeroIntroInfo.init(name: "Genji", image: UIImage.init(named: "Hero-Genji")!, diff: 3, type: HeroType.Offense,id: 4)
        let Mcree = HeroIntroInfo.init(name: "Mcree", image: UIImage.init(named: "Hero-Mcree")!, diff: 3, type: HeroType.Offense,id: 8)
        
        
        tempArray.append(lucio)
        tempArray.append(Sodier76)
        tempArray.append(Genji)
        tempArray.append(Mcree)
        
        heroArray = tempArray
        
        CELLCOUNT = heroArray.count
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
        return CELLCOUNT
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! HeroCell
        // Configure the cell...
        let foreImage = cell.foregroundView.subviews[0] as! UIImageView
        foreImage.image = heroArray[indexPath.row].topImage
        //print(cell.containerView.subviews.count)
        //print(cell.containerView.subviews[0].subviews.count)
        let backImage = cell.containerView.subviews[0].subviews[0] as! UIImageView
        backImage.image = heroArray[indexPath.row].topImage
        //backImage.image = heroArray[indexPath.row].topImage
        //let btnView = cell.contentView.viewWithTag(1)?.subviews[0] as! UIButton
        //let recognizer = UITapGestureRecognizer()
        //recognizer.addTarget(self, action: #selector(handleMoreInfoButtonTapped))
        //recognizer.numberOfTapsRequired = 1;
        //btnView.addGestureRecognizer(recognizer)
        //btnView.addTarget(self, action: #selector(self.handleMoreInfoButtonTapped(_:)), for: .touchDown)
        //btnView.isUserInteractionEnabled = true;
        
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
        }, completion: nil)
    }
    
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
        //print(segue.identifier)
        if segue.identifier == "SegueHeroDetail"
        {
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

