//
//  GameSettingsViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 17.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    
    @IBOutlet weak var setNumberOfRoundsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuSettingsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var setTimeOutlet: UISegmentedControl!
    
    
    var playerOneNameVar = ""
    var playerTwoNameVar = ""
    var cpuDifficulty = -1
    var numberRounds = 0
    var gameTime: NSTimeInterval = 0.0
    
    
    
    // Segment Control: CPU Settings
    @IBAction func cpuSettings(sender: AnyObject) {
        
        switch cpuSettingsOutlet.selectedSegmentIndex{
            
        case 0:
            cpuDifficulty = 1
        case 1:
            cpuDifficulty = 2
        case 2:
            cpuDifficulty = 3
        default:
            cpuDifficulty = -1
            break
        }
    }
  
    
    // Segment Contol: Rounds
    @IBAction func setNumberOfRounds(sender: AnyObject) {
        
        switch setNumberOfRoundsOutlet.selectedSegmentIndex{
            
        case 0:
            numberRounds = 20
        case 1:
            numberRounds = 40
        case 2:
            numberRounds = 1000
        default:
            break
        }
        
    }

    // Segment Control: Time
    @IBAction func setTime(sender: AnyObject) {
        
        switch setTimeOutlet.selectedSegmentIndex{
            
        case 0:
            gameTime = 600.0
        case 1:
            gameTime = 1200.0
        case 2:
            gameTime = 1000000.0
        default:
            break
        
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerOneName.delegate = self
        playerOneName.tag = 0
        playerTwoName.delegate = self
        playerTwoName.tag = 1

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
    
    
    //Hide Keyboard after typing
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if playerTwoName.tag == 0{
            playerOneNameVar = textField.text!
        }else{
            playerTwoNameVar = textField.text!
        }
        
        self.view.endEditing(true)
        return false
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
