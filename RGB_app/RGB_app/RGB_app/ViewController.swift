//
//  ViewController.swift
//  RGB_app
//
//  Created by Hikaru on 2016/06/27.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greyLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var greySlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var resetButton: UIButton!
    
    var defaultSliderValue:Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redLabel.text = String(format: "%.2f",defaultSliderValue)
        greenLabel.text = String(format: "%.2f",defaultSliderValue)
        blueLabel.text = String(format: "%.2f",defaultSliderValue)
        redSlider.value = defaultSliderValue
        greenSlider.value = defaultSliderValue
        blueSlider.value = defaultSliderValue
        
        
        greyAction(greySlider)
    }

    @IBAction func greyAction(sender: UISlider) {
        view.backgroundColor = UIColor(white: CGFloat(sender.value), alpha: 1)
        greyLabel.text = String(format: "%.2f",sender.value)
    }

    @IBAction func RGBAction(sender: AnyObject) {
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value
        redLabel.text = String(format: "%.2f",red)
        greenLabel.text = String(format: "%.2f",green)
        blueLabel.text = String(format: "%.2f",CGFloat(blue))
        
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        
        
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        redLabel.text = "0.5"
        viewDidLoad()
    }
}

