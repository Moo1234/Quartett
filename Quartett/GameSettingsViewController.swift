//
//  GameSettingsViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 17.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController {

    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    

    
  

    override func viewDidLoad() {
        super.viewDidLoad()

        playerTwoName.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    @IBAction func oneOrTwoPlayer(sender: AnyObject) {
      
        if(playerTwoName.hidden == true){
            playerTwoName.hidden = false
        }else{
            playerTwoName.hidden = true
        }
        
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
