//
//  ViewController.swift
//  Keypad
//
//  Created by grade on 25.10.18.
//  Copyright © 2018 grade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var numButotns: [UIButton]!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var eraseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textLabel.text = nil
        eraseButton.isHidden = true
        
        callButton.backgroundColor = UIColor.green
        callButton.layer.cornerRadius = callButton.frame.width / 2
    
        for button in numButotns {
            button.layer.cornerRadius = button.frame.width/2
        }
    }

    @IBAction func buttonTap(_ sender: UIButton) {
        if let buttonTitle = sender.currentTitle {
            textLabel.text = (textLabel.text ?? "") + buttonTitle
        }
        
        updateEraseButton()
    }
    
    @IBAction func erase() {
        textLabel.text = "\(textLabel.text?.dropLast() ?? "")"
        updateEraseButton()
    }
    @IBAction func zeroLongPress(_ sender: Any) {
        if (sender as? UILongPressGestureRecognizer)?.state == .began{
            textLabel.text = (textLabel.text ?? "") + "+"
        }
        
    }
    
    func updateEraseButton() {
    eraseButton.isHidden = textLabel.text?.isEmpty ?? true
    }
}

