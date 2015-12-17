//
//  GameSettingsViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 17.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    
    @IBOutlet weak var cpuSettingsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBAction func cpuSettings(sender: AnyObject) {
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let modelName = UIDevice.currentDevice().modelName
        if modelName == "iPhone 4" || modelName == "iPhone 4s" {
            scrollView.contentSize.height = 800;
        }else if modelName == "iPhone 5" || modelName == "iPhone 5s" {
            scrollView.contentSize.height = 700
        }
        playerTwoName.hidden = true
        cpuLabel.hidden = false
        cpuSettingsOutlet.hidden = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    @IBAction func oneOrTwoPlayer(sender: AnyObject) {
      
        if(playerTwoName.hidden == true){
            playerTwoName.hidden = false
            cpuLabel.hidden = true
            cpuSettingsOutlet.hidden = true
        }else{
            playerTwoName.hidden = true
            cpuLabel.hidden = false
            cpuSettingsOutlet.hidden = false
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
