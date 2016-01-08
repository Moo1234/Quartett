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

    
    @IBOutlet weak var gameOverImage: UIImageView!
    @IBOutlet weak var gameOverText: UITextView!
    
    var labelTxt: String = "Game Over Text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        gameOverText.text = labelTxt
//        gameOverText.selectable = false
        if(gameOverText.text == "Du hast gewonnen!"){
            gameOverImage.image = UIImage(named: "winLogo")
        }else if(gameOverText.text == "Unentschieden!"){
            gameOverImage.image = UIImage(named: "drawLogo")
        }
        else{
            gameOverImage.image = UIImage(named: "looseLogo")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
