//
//  ViewController.swift
//  Animal Facts
//
//  Created by Hikaru on 2016/06/28.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var randomHeaderLabel: UILabel!
    @IBOutlet weak var crazyFactsLabel: UILabel!
    @IBOutlet weak var facts: UILabel!
    @IBOutlet weak var factButton: UIButton!
    
    let banner = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    
    let factsForBanner = RandomFacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        banner.hidden = false
        banner.center.x = 182
        banner.center.y = 274
        banner.frame.size.width = 300
        banner.frame.size.height = 125
        view.addSubview(banner)
        
        //add the facts label to banner
        label.frame = CGRect(x: 0, y: 0, width: banner.frame.size.width, height: banner.frame.size.height - 50)
        label.font = UIFont(name: "Baskerville-Bold", size: 17)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .Center
        label.numberOfLines = 0
        banner.addSubview(label)
        
        //label.text = factsForBanner.randomFact()
        self.label.text = self.factsForBanner.randomFact()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //set our starting points for the views
        factButton.center.y += 30.0
        factButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        crazyFactsLabel.center.x -= view.bounds.width
        randomHeaderLabel.center.x += view.bounds.width
        
        //animate randomHeaderLabel
        UIView.animateWithDuration(0.7, delay: 0.0, options:UIViewAnimationOptions.CurveEaseOut,animations: {
            self.randomHeaderLabel.center.x -= self.view.bounds.width
        }, completion: nil)
        
        //animate crazyFactsLabel
        UIView.animateWithDuration(0.9, delay: 0.1, options:UIViewAnimationOptions.CurveEaseOut,animations: {
            self.crazyFactsLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        //animate factButton with springs
        UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.factButton.center.y -= 30.0
            self.factButton.alpha = 1.0
            }, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.label.text = factsForBanner.randomFact()
        showFact()
    }
    
    func showFact() {
        UIView.animateWithDuration(0.33,delay:0.0, usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0, options: [], animations:{
                //first move away any message that over the banner by moving to the right
                self.banner.center.x += self.view.frame.width
            },completion: {_ in
                self.label.text = self.factsForBanner.randomFact()
                self.banner.hidden = true
                self.banner.center.x -= self.view.frame.width
                
                UIView.transitionWithView(self.banner, duration: 0.3, options: [.CurveEaseOut,UIViewAnimationOptions.TransitionFlipFromTop], animations:{ self.banner.hidden = false
                    }, completion: nil)
    })
    }

}

