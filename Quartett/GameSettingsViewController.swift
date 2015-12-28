//
//  GameSettingsViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 17.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData


class GameSettingsViewController: UIViewController, UITextFieldDelegate {
    
    //GUI-elements
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    
    @IBOutlet weak var setNumberOfRoundsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuSettingsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var setTimeOutlet: UISegmentedControl!
    
    @IBAction func openSetGalery(sender: AnyObject) {
    }
    //Vars
    var dataPassed: Int!
    var playerOneNameVar = ""
    var playerTwoNameVar = ""
    var cpuDifficulty = 1
    var numberLaps = 20
    var gameTime: NSTimeInterval = 600.0
    var setID: Int = -1
    
    
    
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
            break
        }
    }
    
    
    // Segment Contol: Rounds
    @IBAction func setNumberOfRounds(sender: AnyObject) {
        
        switch setNumberOfRoundsOutlet.selectedSegmentIndex{
            
        case 0:
            numberLaps = 20
        case 1:
            numberLaps = 40
        case 2:
            numberLaps = 1000
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
        if textField.tag == 0{
            playerOneNameVar = textField.text!
        }else{
            playerTwoNameVar = textField.text!
        }
        
        self.view.endEditing(true)
        return false
    }
    
    
    //hide or show textfield player2
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
    
    
    //Starts and creates Game (Button: Spiel Starten)
    @IBAction func createNewGame(sender: AnyObject) {
        
        //print(setID)
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        if playerTwoName.hidden == false{
            
            cpuDifficulty = -1
        }else{
            playerTwoNameVar = "SinglePlayerGame"
        }
        
        let random = Int(arc4random_uniform(2) + 1)
        var whoStarts = true
        
        
        if random == 1{
            whoStarts = true
        }else{
            whoStarts = false
        }
        
        
        var newGame = NSEntityDescription.insertNewObjectForEntityForName("Game", inManagedObjectContext: context)
        

        
        //set Values
        //cardSet:
        newGame.setValue(2, forKey: "cardset")
        newGame.setValue(cpuDifficulty, forKey: "difficulty")
        newGame.setValue(numberLaps, forKey: "laps")
        //Max Laps?? :
        newGame.setValue(100, forKey: "maxLaps")
        // Max Time?? :
        newGame.setValue(100.0, forKey: "maxTime")
        newGame.setValue(playerOneNameVar, forKey: "player1")
        //player one cards:
        newGame.setValue("JO", forKey: "player1Cards")
        newGame.setValue(playerTwoNameVar, forKey: "player2")
        // player two cards:
        newGame.setValue("Jo2", forKey: "player2Cards")
        newGame.setValue(gameTime, forKey: "time")
        newGame.setValue(whoStarts, forKey: "turn")
        
        
        do {
            try context.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        /*
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Game")
        do {
        let results =
        try managedContext.executeFetchRequest(fetchRequest)
        var bla = results as! [NSManagedObject]
        let bla2 = bla[0]
        print(bla2.valueForKey("player1"))
        } catch let error as NSError {
        print("Could not fetch \(error), \(error.userInfo)")
        }
        
        */
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
