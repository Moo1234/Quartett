//
//  ViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 19.11.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingButton.layer.borderWidth = 2
        galleryButton.layer.borderWidth = 2
        newGameButton.layer.borderWidth = 2
        
        rankingButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        galleryButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        newGameButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

