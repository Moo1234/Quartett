//
//  EndScreenViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 07.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData


class EndScreenViewController: UIViewController {

    
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    
    
    @IBOutlet weak var gameOverImage: UIImageView!
    @IBOutlet weak var gameOverText: UILabel!
    
    var labelTxt: String = "Game Over Text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOverText.text = labelTxt
        if(gameOverText.text == "Du hast gewonnen!"){
            gameOverImage.image = UIImage(named: "winLogo")
        }else if(gameOverText.text == "Unentschieden!"){
            gameOverImage.image = UIImage(named: "drawLogo")
        }
        else{
            gameOverImage.image = UIImage(named: "looseLogo")
        }
        
        rankingButton.layer.borderWidth = 2
        mainMenuButton.layer.borderWidth = 2
        newGameButton.layer.borderWidth = 2
        
        rankingButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        mainMenuButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        newGameButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
