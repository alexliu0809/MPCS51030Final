//
//  DiscoverFunctionController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import SwiftyJSON

//Discover Function type
enum functionType{
    case whatsToday
    case heroRecommend
    case lookingForGroup
    case none
}

class DiscoverFunctionController: UIViewController, SurveyDelegate, DrawHeroDelegate {

    var functionType: functionType = .none
    
    //seperate view for different function, one exists other two nil
    var survey: HeroRecommendationSurvey?
    var draw: DrawRandomHero?
    var LFG: UITableView?
    
    //data structure, since we show LFG as tableview
    var posts: [LFGMessage] = LFGMessage.Messages
    
    //tell if this controller showed by discoverController initialization or user
    //flipping from other controller
    var triggeredBySegue: Bool = true
    
    //selected hero
    var selectedHero: HeroIntroInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self-size background image
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "discover-bg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    //get survey result, make selection
    func getSurveyResult(_ hero: HeroIntroInfo) {
        selectedHero = hero
        heroSelection(hero)
    }
    
    //get draw result, make selection
    func getDrawResult(_ hero: HeroIntroInfo){
        selectedHero = hero
        heroSelection(hero)
    }
    
    
    //make selection, trigger segue to heroDetailController
    func heroSelection(_ hero: HeroIntroInfo){
        performSegue(withIdentifier: "discoverToHero", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "discoverToHero"{
            guard let destination = (segue.destination as? HeroDetailController) else{
                return
            }
            //set what heroDetail will show
            destination.detailItem = selectedHero
        }
    }
    
    //clean all views
    func clear(){
        if (survey != nil){
            survey!.removeFromSuperview()
        }
        
        if (draw != nil){
            draw!.removeFromSuperview()
        }
        
        if (LFG != nil){
            LFG!.removeFromSuperview()
        }
    }
    
    //after clear all existing function, reset them
    //create the function according to user's pick
    func reset(){
        switch functionType {
        case .whatsToday:
            self.draw = DrawRandomHero()
            self.view.addSubview(self.draw!)
            self.view.addSubview((draw?.stopButton)!)
            self.view.addSubview((draw?.detailButton)!)
            draw?.delegate = self
        case .heroRecommend:
            self.survey = HeroRecommendationSurvey()
            self.view.addSubview(survey!)
            self.view.addSubview((survey?.option1)!)
            self.view.addSubview((survey?.option2)!)
            self.view.addSubview((survey?.option3)!)
            self.view.addSubview((survey?.option4)!)
            self.view.addSubview((survey?.stopButton)!)
            self.view.addSubview((survey?.detailButton)!)
            survey?.delegate = self
            survey?.surveyStart()
        case .lookingForGroup:
            self.LFG = UITableView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
            LFG?.delegate = self
            LFG?.dataSource = self
            LFG?.register(LFGCell.self, forCellReuseIdentifier: "lfgCell")
            self.view.addSubview(LFG!)
            LFG?.estimatedRowHeight = 300
            LFG?.rowHeight = UITableViewAutomaticDimension
            LFG?.reloadData()
            
            //cell self-sizing
            LFG?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            LFG?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            LFG?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            LFG?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            LFG?.separatorColor = UIColor(hexString: "242424")
            LFG?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            LFG?.tableFooterView = UIView(frame: .zero)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //if triggered by segue, user want a new function
        //if not, user came back from other controller, dont reset
        if triggeredBySegue {
            triggeredBySegue = false
            clear()
            reset()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NSLog("Discover function will disappear")
        //if user navi away, stop the drawing timer
        if functionType == .whatsToday{
            draw!.stop()
        }
    }
    
    //not used, fetching LFG messages
    func fetchLFGData() -> [(String,String,UIImage)] {
        var ret: [(String,String,UIImage)] = []
        SharedNetworking.Shared.fetchData(URLString: "", completion: {
            JsonData in
            
            let json = JSON(data: JsonData!)
            for i in json.array!{
                var avatar: UIImage = UIImage()
                
                SharedNetworking.Shared.fetchImage(URLString: i["avatar"].string!, completion: { img in
                    avatar = img!
                })
                let battleID = i["ID"].string
                let descrip = i["Content"].string
                ret.append((battleID!,descrip!,avatar))
            }
        })
        
        return ret
    }
    
    //incase survey didn't find a hero, let
    //user decide if do it again
    func heroNotFound() {
        let alert = UIAlertController(title: "No match", message: nil, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Try again", style: .default, handler: {
            action in
            self.survey?.restart()
        })
        let action2 = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            alert.dismiss(animated: true, completion: {})
        })
        alert.addAction(action1)
        alert.addAction(action2)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    
}

//LFG is a UItableview, extention
extension DiscoverFunctionController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lfgCell", for: indexPath) as! LFGCell
        cell.descrip.isScrollEnabled = false
        let marginGuide = cell.contentView.layoutMarginsGuide
        cell.avatar.clipsToBounds = true
        cell.battleID.clipsToBounds = true
        cell.descrip.clipsToBounds = true
        cell.avatar.layer.cornerRadius = cell.avatar.frame.height / 2
        cell.descrip.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        cell.descrip.layer.cornerRadius = 5
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        cell.avatar.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cell.avatar.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cell.avatar.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        cell.battleID.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cell.descrip.leadingAnchor.constraint(equalTo: cell.avatar.trailingAnchor).isActive = true
        cell.descrip.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cell.descrip.topAnchor.constraint(equalTo: cell.battleID.bottomAnchor).isActive = true
        cell.descrip.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        cell.clipsToBounds = true
        cell.avatar.image = posts[indexPath.item].avatar
        cell.battleID.text = posts[indexPath.item].battleID
        cell.descrip.text = posts[indexPath.item].descrip
        cell.descrip.sizeToFit()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


