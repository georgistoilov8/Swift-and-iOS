//
//  ViewController.swift
//  CrazyBunny
//
//  Created by Spas Bilyarski on 8.01.18.
//  Copyright © 2018 spasbilyarski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var bunnyImageView: UIImageView!
    @IBOutlet weak var grassImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bunnyImageView.center = view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let animationHide = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animationHide.beginTime = 0
        animationHide.fromValue = 1
        animationHide.toValue = 0
        animationHide.duration = 1
        
        let animationShow = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animationShow.beginTime = animationHide.beginTime + animationHide.duration
        animationShow.duration = 1
        animationShow.fromValue = 0
        animationShow.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationHide, animationShow]
        animationGroup.duration = animationShow.duration + animationHide.duration
        //animationGroup.repeatCount = .infinity
        bunnyImageView.layer.add(animationGroup, forKey: "AnimationGroup")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helpers
    
    func randomColor() -> UIColor {
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0;
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        var newFrame = self.grassImageView.frame;
        newFrame.size.height -= 50
        newFrame.origin.y += 50
        UIView.animate(withDuration: 0.3, animations: {
            self.bunnyImageView.backgroundColor = self.randomColor()
            self.grassImageView.frame = newFrame
        })
    }
}

