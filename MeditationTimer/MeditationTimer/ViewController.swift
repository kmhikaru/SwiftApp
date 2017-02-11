//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Hikaru on 2016/06/30.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("gong", ofType: "mp3")!))
    
    var timer = NSTimer()
    let timeDisplayInterval: NSTimeInterval = 0.5 // interval to display the time,this updates the time label every second but we set it to 0.5 which makes it super accurate ... if we set this to 10 seconds it will only display the time every 10 secondes
    
    var secondsToEndTimer: NSTimeInterval = 0.0 //seconds to end the timer... holds the users selected choise in seconds
    
    var timeIntervalCounter: NSTimeInterval = 0.0 //counter for the timer, helps us keep track of the timer so we can update the label with the correct time 
    
    var checkIfTiming = false //a bool var thats helpful when finding out if the timer is running
    
    //timer outlets
    @IBOutlet weak var timeDisplayLabel: UILabel!
    @IBOutlet weak var upOrDownSwitch: UISwitch!
    
    //button outlets
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button25: UIButton!
    @IBOutlet weak var button30: UIButton!
    @IBOutlet weak var button35: UIButton!
    @IBOutlet weak var button40: UIButton!
    @IBOutlet weak var button60: UIButton!
    @IBOutlet weak var button70: UIButton!
    @IBOutlet weak var button80: UIButton!
    @IBOutlet weak var button90: UIButton!
    
    //imageView outlets to hold the highlighted button images
    @IBOutlet weak var button15Highlighted: UIImageView!
    @IBOutlet weak var button20Highlighted: UIImageView!
    @IBOutlet weak var button25Highlighted: UIImageView!
    @IBOutlet weak var button30Highlighted: UIImageView!
    @IBOutlet weak var button35Highlighted: UIImageView!
    @IBOutlet weak var button40Highlighted: UIImageView!
    @IBOutlet weak var button60Highlighted: UIImageView!
    @IBOutlet weak var button70Highlighted: UIImageView!
    @IBOutlet weak var button80Highlighted: UIImageView!
    @IBOutlet weak var button90Highlighted: UIImageView!
    
    //startPause outlet to change the start to the pause image
    @IBOutlet weak var startPauseOutlet: UIButton!
    
    
    
    //reset outlet to change the shape of the reset button
    @IBOutlet weak var resetButton: UIButton!
    
    //switch outlet
    @IBOutlet weak var countUpOrDownSwitch: UISwitch!
    
    //var to check the state of the startPauseButton to display the correct image
    var startPauseButtonStateCheck = true
    
    //heartBeads vars and array
    var heartBeadsTimer = NSTimer()
    var heartBeadsIndex = 0
    var isAnimating = true
    
    let imagesArrayHeartBeads: [String] = ["heartBead1","heartBead2","heartBead3","heartBead4","heartBead5","heartBead6","heartBead7","heartBead8","heartBead9","heartBead10","heartBead11","heartBead12","heartBead13","heartBead14","heartBead15","heartBead16","heartBead17","heartBead18","heartBead19","heartBead20","heartBead21","heartBead22","heartBead23","heartBead24","heartBead25","heartBead26","heartBead27",]
    
    @IBOutlet weak var heartBeadImageView: UIImageView!
    
    //incense vars and array
    var incenseTimer = NSTimer()
    var incenseIndex = 0
   
    let imagesArrayIncense: [String] = ["incenseStick1","incenseStick2","incenseStick3","incenseStick4","incenseStick5","incenseStick6","incenseStick7","incenseStick8"]
    
    @IBOutlet weak var incenseImageView: UIImageView!
    
    
    override func viewDidLoad() {
        
        //start the incense timer when the view loads up
        incenseTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self,selector: "animateIncense", userInfo: nil, repeats: true)
        
        super.viewDidLoad()
        button15Highlighted.hidden = true
        button20Highlighted.hidden = true
        button25Highlighted.hidden = true
        button30Highlighted.hidden = true
        button35Highlighted.hidden = true
        button40Highlighted.hidden = true
        button60Highlighted.hidden = true
        button70Highlighted.hidden = true
        button80Highlighted.hidden = true
        button90Highlighted.hidden = true
        
        resetButton.layer.cornerRadius = 15
        resetButton.layer.shadowOpacity = 0.9
        resetButton.layer.shadowOffset = CGSize(width: 1.0, height: 0.5)
        resetButton.layer.shadowColor = UIColor.blackColor().CGColor
    }

    @IBAction func startPausePressed(sender: AnyObject) {
        //change the image
        if startPauseButtonStateCheck {
            let pause = UIImage(named: "pauseButton") as UIImage!
            startPauseOutlet.setImage(pause, forState: .Normal)
            startPauseButtonStateCheck = false
            //add shadow to pause button
            startPauseOutlet.layer.shadowOpacity = 0.9
            startPauseOutlet.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
            startPauseOutlet.layer.shadowRadius = 5.0
            startPauseOutlet.layer.shadowColor = UIColor.blackColor().CGColor
        } else {
            let start = UIImage(named: "start") as UIImage!
            startPauseOutlet.setImage(start, forState: .Normal)
            startPauseButtonStateCheck = true
        }
        
        if !timer.valid{
            //start timer
            timer = NSTimer.scheduledTimerWithTimeInterval(timeDisplayInterval, target: self, selector: "checkIfUserTimeIsReached:", userInfo: nil, repeats: true)
            timeDisplayLabel.text = formattedTimeString(timeIntervalCounter)
            checkIfTiming = true
        } else {
            timeDisplayLabel.text = formattedTimeString(timeIntervalCounter)
            timer.invalidate()
        }
        
    }
    
    func formattedTimeString (time: NSTimeInterval) -> String{
        let min = Int(time) / 60
        let secs = Int(time) % 60
        //let fracs = Int((time - Double(secs))* 10.0)
        return String(format:"%02i:%02i",min,secs)
    }
    
    func checkIfUserTimeIsReached(timer:NSTimer){
        
        if upOrDownSwitch.on {
        
            //timer counting down from a user selected time to 0
            //minus the amount of seconds thats in the timeDisplayInterval from the second to itself (updating the tie) because its started in the startTimePressed action, so this statement makes the timer count timeIntervalCounter after every second that passes because this func is called every second by tye NSTimer.scheduledTimeWithTimeIntreval(timeDisplayInterval call in startTimerPressedaction
            timeIntervalCounter -= timeDisplayInterval
            if timeIntervalCounter <= 0{ //test for users selected time if reached
                audioPlayer.play()
                timeDisplayLabel.text = "Session Finished"
                // play heart animation
                heartBeadsTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,target: self, selector: "animateHeartBeads", userInfo: nil, repeats: true)
                timer.invalidate()
                checkIfTiming = false
                
                //change startPauseButton to the start image
                let start = UIImage(named: "start") as UIImage!
                startPauseOutlet.setImage(start, forState: .Normal)
                
                //remove shadow from start button
                startPauseOutlet.layer.shadowOpacity = 0.0
            } else {
                //update the time on the timeDisplayLabel if selected time is not reached
                timeDisplayLabel.text = formattedTimeString(timeIntervalCounter)
            }
        } else {
            //timer counting up from a user selected time to 0
            timeIntervalCounter += timeDisplayInterval
            if timeIntervalCounter >= secondsToEndTimer{ //check if the user selected time is reached
                timeDisplayLabel.text = "Session Finished"
                audioPlayer.play()
                // play heart animation
                // heartBeadsTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,target: self, selector: "animateHeartBeads", userInfo: nil, repeats: true)
                timer.invalidate()
                checkIfTiming = false
                
                //change startPauseButton to the start image
                let start = UIImage(named: "start") as UIImage!
                startPauseOutlet.setImage(start, forState: .Normal)
                
                //remove shadow from start button
                startPauseOutlet.layer.shadowOpacity = 0.0
            } else {
                //update the time on the timeDisplayLabel if selected time is not reached
                timeDisplayLabel.text = formattedTimeString(timeIntervalCounter)
            }
        }
            
    }
    
    
    @IBAction func timeSelectPressed(sender: AnyObject) {
        if sender.tag == 15{
            setAllButtonSelectionsToNormal()
            button15.setImage(UIImage(named: "button15Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button15Highlighted.hidden = false
            secondsToEndTimer = 15 * 60
            resetTimer(self)
        }
        if sender.tag == 20{
            setAllButtonSelectionsToNormal()
            button20.setImage(UIImage(named: "button20Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button20Highlighted.hidden = false
            secondsToEndTimer = 20 * 60
            resetTimer(self)
        }
        if sender.tag == 25{
            setAllButtonSelectionsToNormal()
            button25.setImage(UIImage(named: "button25Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button25Highlighted.hidden = false
            secondsToEndTimer = 25 * 60
            resetTimer(self)
        }
        if sender.tag == 30{
            setAllButtonSelectionsToNormal()
            button30.setImage(UIImage(named: "button30Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button30Highlighted.hidden = false
            secondsToEndTimer = 30 * 60
            resetTimer(self)
        }
        if sender.tag == 35{
            setAllButtonSelectionsToNormal()
            button35.setImage(UIImage(named: "button35Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button35Highlighted.hidden = false
            secondsToEndTimer = 35 * 60
            resetTimer(self)
        }
        if sender.tag == 40{
            setAllButtonSelectionsToNormal()
            button40.setImage(UIImage(named: "button40Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button40Highlighted.hidden = false
            secondsToEndTimer = 40 * 60
            resetTimer(self)
        }
        if sender.tag == 60{
            setAllButtonSelectionsToNormal()
            button60.setImage(UIImage(named: "button60Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button60Highlighted.hidden = false
            secondsToEndTimer = 60 * 60
            resetTimer(self)
        }
        if sender.tag == 70{
            setAllButtonSelectionsToNormal()
            button70.setImage(UIImage(named: "button70Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button70Highlighted.hidden = false
            secondsToEndTimer = 70 * 60
            resetTimer(self)
        }
        if sender.tag == 80{
            setAllButtonSelectionsToNormal()
            button80.setImage(UIImage(named: "button80Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button80Highlighted.hidden = false
            secondsToEndTimer = 80 * 60
            resetTimer(self)
        }
        if sender.tag == 90{
            setAllButtonSelectionsToNormal()
            button90.setImage(UIImage(named: "button90Highlighted"),forState: .Normal)
            hideAllButtonSelectionsFromStartPauseButton()
            button90Highlighted.hidden = false
            secondsToEndTimer = 90 * 60
            resetTimer(self)
        }
    }
    
    func setAllButtonSelectionsToNormal(){
    
        button15.setImage(UIImage(named: "15"), forState: .Normal)
        button20.setImage(UIImage(named: "20"), forState: .Normal)
        button25.setImage(UIImage(named: "25"), forState: .Normal)
        button30.setImage(UIImage(named: "30"), forState: .Normal)
        button35.setImage(UIImage(named: "35"), forState: .Normal)
        button40.setImage(UIImage(named: "40"), forState: .Normal)
        button60.setImage(UIImage(named: "60"), forState: .Normal)
        button70.setImage(UIImage(named: "70"), forState: .Normal)
        button80.setImage(UIImage(named: "80"), forState: .Normal)
        button90.setImage(UIImage(named: "90"), forState: .Normal)
        
    }
    
    func hideAllButtonSelectionsFromStartPauseButton(){
       
        button15Highlighted.hidden = true
        button20Highlighted.hidden = true
        button25Highlighted.hidden = true
        button30Highlighted.hidden = true
        button35Highlighted.hidden = true
        button40Highlighted.hidden = true
        button60Highlighted.hidden = true
        button70Highlighted.hidden = true
        button80Highlighted.hidden = true
        button90Highlighted.hidden = true
       
    }
    
    @IBAction func resetTimer(sender: AnyObject) {
        
        timer.invalidate()
        heartBeadsTimer.invalidate()
        
        if upOrDownSwitch.on {
            timeIntervalCounter = secondsToEndTimer
            timeDisplayLabel.text = formattedTimeString(timeIntervalCounter)
        } else {
            timeIntervalCounter = 0.0
            timeDisplayLabel.text = formattedTimeString(timeIntervalCounter)
        }
        
        heartBeadImageView.image = UIImage(named: "")
        checkIfTiming = false
        
        //change startPauseButton to the start image
        let start = UIImage(named: "start") as UIImage!
        startPauseOutlet.setImage(start, forState: .Normal)
        
        //remove shadow from start button
        startPauseOutlet.layer.shadowOpacity = 0.0
        
        startPauseButtonStateCheck = true
        
        //add shadow to the resetButton
        resetButton.layer.shadowOpacity = 1.0
        resetButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        resetButton.layer.shadowRadius = 2.0
        resetButton.layer.shadowColor = UIColor.blackColor().CGColor
    }
    
    @IBAction func resetUpOrDownSwitch(sender: AnyObject) {
        //change startPauseButton to the start image
        let start = UIImage(named: "start")
        startPauseOutlet.setImage(start, forState: .Normal)
        
        //remove shadow from start button
        startPauseOutlet.layer.shadowOpacity = 0.0
        
        startPauseButtonStateCheck = true
        
        resetTimer(self)
        
    }
    
    @IBAction func startPauseShadowTouchDownAction(sender: AnyObject) {
        startPauseOutlet.layer.shadowOpacity = 1.0
        startPauseOutlet.layer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        startPauseOutlet.layer.shadowRadius = 1.0
        startPauseOutlet.layer.shadowColor = UIColor.blackColor().CGColor
        
    }

    @IBAction func resetButtonShadowTouchDownAction(sender: AnyObject) {
        resetButton.layer.shadowOpacity = 1.0
        resetButton.layer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        resetButton.layer.shadowRadius = 1.0
        resetButton.layer.shadowColor = UIColor.blackColor().CGColor
    }

    func animateHeartBeads() {
        if heartBeadsIndex == imagesArrayHeartBeads.count - 1 {
            heartBeadsIndex = 1
            heartBeadsTimer.invalidate()
        } else {
            heartBeadsIndex += 1
        }
        heartBeadImageView.image = UIImage(named: imagesArrayHeartBeads[heartBeadsIndex])
        isAnimating = true
    }
   
    func animateIncense(){
        if incenseIndex == imagesArrayIncense.count - 1 {
           incenseIndex = 0
        } else {
           incenseIndex += 1
        }
        incenseImageView.image = UIImage(named: imagesArrayIncense[incenseIndex])
        isAnimating = true
    }
    
}

