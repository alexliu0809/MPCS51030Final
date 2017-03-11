//
//  SplashScreenController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import GLKit

class SplashScreenController: UIViewController {

    @IBOutlet weak var overwatch: UILabel!
    
    @IBOutlet weak var companion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        companion.alpha = 0
        self.addCircleView(0.7)
        
        
        DispatchQueue.main.async {
            sleep(2)
            
            UIView.animate(withDuration: 0.7, animations: {
                self.overwatch.alpha = 0
                self.overwatch.center.y -= 123
                self.companion.alpha = 1
                self.companion.center.y -= 123
                
                
            }, completion: {
                finish in
                sleep(2)
                self.performSegue(withIdentifier: "showMain", sender: self)
            })
        }
        
        let dispatchtime = DispatchTime.now()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCircleView(_ duration:Double) {
        
        //let circleWidth = CGFloat(200)
        //let circleHeight = circleWidth
        
        // Create a new CircleView
        //7,283,100,100
        let circleView = Arch(frame: CGRect(x: 7+25, y:283+25, width: 50, height: 50))
        //let test = CircleView(frame: CGRect(x: diceRoll, y: 0, width: circleWidth, height: circleHeight))
        
        view.addSubview(circleView)
        circleView.animateCircle(duration: 1.0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable class Arch: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    var circleLayer: CAShapeLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat(M_PI * 1/4), endAngle: CGFloat(M_PI * 7/4), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(red: 248.0/255.0, green: 158.0/255.0, blue: 25.0/255.0, alpha: 1.0).cgColor
        circleLayer.lineWidth = 8.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0 //1.0 show 0.0 hide
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    
    /*
     @IBInspectable var counter: Int = 5
     @IBInspectable var outlineColor: UIColor = UIColor.blue
     @IBInspectable var counterColor: UIColor = UIColor.orange
     
     override func draw(_ rect: CGRect) {
     // 1
     let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
     
     // 2
     let radius: CGFloat = max(bounds.width, bounds.height)
     
     // 3
     let arcWidth: CGFloat = 76
     
     // 4
     let startAngle: CGFloat =  π / 4
     let endAngle: CGFloat = 7 * π / 4
     
     // 5
     var path = UIBezierPath(arcCenter: center,
     radius: radius/2 - arcWidth/2,
     startAngle: startAngle,
     endAngle: endAngle,
     clockwise: true)
     
     // 6
     path.lineWidth = arcWidth
     counterColor.setStroke()
     path.stroke()
     }
     */
    
}


