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
        
        self.clearsSelectionOnViewWillAppear = false
    }
    
    /** **/
    func initializeHeros()
    {
        var tempArray:[HeroIntroInfo] = []
        
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

