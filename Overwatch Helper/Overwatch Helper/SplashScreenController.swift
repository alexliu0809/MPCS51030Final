//
//  SplashScreenController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import GLKit


let NoOfGlasses = 8 //A circle divided to 8 pieces

let π:CGFloat = CGFloat(M_PI) // Define pai

class SplashScreenController: UIViewController {

    
    /// Overwatch label
    @IBOutlet weak var overwatch: UILabel!
    
    // Companion Label
    @IBOutlet weak var companion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companion.alpha = 0 // hide the companion for animation
        
        
        
        DispatchQueue.main.async {
            sleep(2)
            self.addCircleView(1.0) //Display the C
            //In the mean time, show companion
            UIView.animate(withDuration: 0.7, animations: {
                self.overwatch.alpha = 0
                self.overwatch.center.y -= 123
                self.companion.alpha = 1
                self.companion.center.y -= 128
                
                
            }, completion: {
                finish in
//              
                //After companion and C show up

                sleep(1)
                UIView.animate(withDuration: 0.3, animations: {
                    self.addWhiteCircleView(0.3) // Add the missing whitie part
                }, completion: {
                    finish in
                    sleep(1)
                    self.performSegue(withIdentifier: "showMain", sender: self) //perform segue to main view
                })
                
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Add a circle C to view
    ///
    /// - Parameter duration: Animation time
    func addCircleView(_ duration:Double) {
        
        //Set C Circle View
        let circleView = Arch(frame: CGRect(x: 7+25, y:283+25, width: 50, height: 50))
        //let test = CircleView(frame: CGRect(x: diceRoll, y: 0, width: circleWidth, height: circleHeight))
        
        view.addSubview(circleView)
        circleView.animateCircle(duration: duration)
    }
    
    
    /// add the missing white part
    ///
    /// - Parameter duration: Animation  time
    func addWhiteCircleView(_ duration: Double)
    {
        //Set white part circle view
        let circleView = WhiteArch(frame: CGRect(x: 7+25, y:283+25, width: 50, height: 50))
        
        view.addSubview(circleView)
        circleView.animateCircle(duration: duration)
    }
    

}



/// Draw the C
@IBDesignable class Arch: UIView {
    
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
    
    
    
}


/// Draw the missing white part
@IBDesignable class WhiteArch: UIView {
    
    
    var circleLayer: CAShapeLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat(M_PI * 7.3/4), endAngle: CGFloat(M_PI * 0.7/4), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
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
        //self.performSegue(withIdentifier: "showMain", sender: self)
    }
    
    
    
}



