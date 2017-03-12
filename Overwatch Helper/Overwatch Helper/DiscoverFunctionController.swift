//
//  DiscoverFunctionController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import SwiftyJSON

enum functionType{
    case whatsToday
    case heroRecommend
    case lookingForGroup
    case none
}

class DiscoverFunctionController: UIViewController, SurveyDelegate, DrawHeroDelegate {

    var functionType: functionType = .none
    var survey: HeroRecommendationSurvey?
    var draw: DrawRandomHero?
    var LFG: UITableView?
    var posts: [LFGMessage] = LFGMessage.Messages
    var triggeredBySegue: Bool = true
    var selectedHero: HeroIntroInfo?
    
//    var result: HeroIntroInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "discover-bg")?.draw(in: self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
//        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "discover-bg"))
        
        // Do any additional setup after loading the view.
    }
    
    func getSurveyResult(_ hero: HeroIntroInfo) {
        selectedHero = hero
        heroSelection(hero)
    }
    
    func getDrawResult(_ hero: HeroIntroInfo){
        selectedHero = hero
        heroSelection(hero)
    }
    
    func heroSelection(_ hero: HeroIntroInfo){
        performSegue(withIdentifier: "discoverToHero", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "discoverToHero"{
            guard let destination = (segue.destination as? HeroDetailController) else{
                return
            }
            print(selectedHero?.heroName)
            destination.detailItem = selectedHero
        }
    }
    
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
    
    
    
    func reset(){
        switch functionType {
        case .whatsToday:
            self.draw = DrawRandomHero()
            self.view.addSubview(self.draw!)
            self.view.addSubview((draw?.stopButton)!)
            self.view.addSubview((draw?.detailButton)!)
            draw?.delegate = self
        //            self.draw?.start()
        case .heroRecommend:
            self.survey = HeroRecommendationSurvey()
            self.view.addSubview(survey!)
            self.view.addSubview((survey?.option1)!)
            self.view.addSubview((survey?.option2)!)
            self.view.addSubview((survey?.option3)!)
            self.view.addSubview((survey?.option4)!)
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
            
            //https://medium.com/@satindersingh71/self-sizing-table-view-cells-programmatically-b0e82a20f264#.watb3p8i1 selfsizing
            LFG?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            LFG?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            LFG?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            LFG?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            LFG?.separatorStyle = .none
            LFG?.backgroundColor = UIColor(netHex: 0x363636)
            LFG?.tableFooterView = UIView(frame: .zero)
            
//            posts = fetchLFGData()
            
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if triggeredBySegue {
            triggeredBySegue = false
            clear()
            reset()
        }else{
//            if functionType == .whatsToday{
//                draw!.start()
//            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("will despe")
        if functionType == .whatsToday{
            draw!.stop()
        }
    }
    
    
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
    

    
}

extension DiscoverFunctionController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lfgCell", for: indexPath) as! LFGCell
        //        cell.avatar = posts[indexPath.item]
        cell.descrip.isScrollEnabled = false
        let marginGuide = cell.contentView.layoutMarginsGuide
        
//        cell.avatar.translatesAutoresizingMaskIntoConstraints = false
//        cell.battleID.translatesAutoresizingMaskIntoConstraints = false
//        cell.descrip.translatesAutoresizingMaskIntoConstraints = false
        cell.avatar.clipsToBounds = true
        cell.battleID.clipsToBounds = true
        cell.descrip.clipsToBounds = true
        cell.avatar.layer.cornerRadius = cell.avatar.frame.height / 2
        cell.descrip.backgroundColor = UIColor(netHex: 0x363636)
        cell.backgroundColor = UIColor(netHex: 0x363636)
        
        cell.avatar.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cell.avatar.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cell.avatar.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
//        cell.avatar.heightAnchor.constraint(equalTo: cell.avatar.widthAnchor).isActive = true
        
        cell.battleID.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        
        cell.descrip.leadingAnchor.constraint(equalTo: cell.avatar.trailingAnchor).isActive = true
        cell.descrip.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cell.descrip.topAnchor.constraint(equalTo: cell.battleID.bottomAnchor).isActive = true
        cell.descrip.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true

        cell.clipsToBounds = true
        
        cell.avatar.image = posts[indexPath.item].avatar
        cell.battleID.text = posts[indexPath.item].battleID
        cell.descrip.text = posts[indexPath.item].descrip
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
}


