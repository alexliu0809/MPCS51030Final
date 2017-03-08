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
    var cellHeights = (0..<2).map { _ in C.CellHeight.close }
    
    //Views
    //@IBOutlet weak var moreView: UIView!
    @IBOutlet var recognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, 
//        typically from a nib.
        //recognizer.addTarget(self, action: #selector(handleMoreInfoButtonTapped))
        //recognizer.numberOfTapsRequired = 1;
        //moreView.addGestureRecognizer(recognizer)
        //moreView.isUserInteractionEnabled = true;
        
    }
    
    func handleMoreInfoButtonTapped(recognizer: UITapGestureRecognizer){
        print("tapped!")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "HeroDetailView") as! HeroDetailController
        self.present(secondViewController, animated:true, completion:nil)
    }

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
    

}

