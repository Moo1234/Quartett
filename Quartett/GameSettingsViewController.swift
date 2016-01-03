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
    @IBOutlet weak var cardSetIcon: UIImageView!
    
    
    
    @IBAction func openSetGalery(sender: AnyObject) {
    }
    //Vars
    var playerOneNameVar = ""
    var playerTwoNameVar = ""
    var cpuDifficulty = 1
    var numberLaps = 20
    var gameTime: NSTimeInterval = 600.0
    var setID: Int = -1
    var cardArray = [NSManagedObject]()
    var player1Cards = [NSManagedObject]()
    var player2Cards = [NSManagedObject]()
    
    
    
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
//        
//        cardSetIcon.layer.borderWidth = 1
//        cardSetIcon.layer.borderColor = UIColor.blackColor().CGColor
        
        
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
        if(setID != -1){
            cardSetIcon.image = UIImage(named: "CardSet" + String(setID))
            loadCardSetWithSetID()
            shuffleCards(cardArray)
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
    
    
    func loadCardSetWithSetID(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
            
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "cardset == %d", setID)
        fetchRequest.predicate = predicate
            
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cardArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
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
    
    
    //Algo shuffle Cards
    func shuffleCards(var arr: [NSManagedObject]){
        var setP1 = Set<NSManagedObject>()
        var setP2 = Set<NSManagedObject>()
        let shuffle = 2 * arr.count
        
        var randomNum: Int = random()  % arr.count
        var randomNum2: Int = random()  % arr.count
        var temp: NSManagedObject
        
        //shuffle
        for var index = 0; index < shuffle; ++index {
            randomNum = random() % arr.count
            randomNum2 = random() % arr.count
            temp = arr[randomNum2]
            arr[randomNum2] = arr[randomNum]
            arr[randomNum] = temp
            
        }
        
        
        //split Arr
        let split = arr.count / 2
        
        for var index3 = 0; index3 < split; ++index3 {
            setP1.insert(arr[index3])
        }
        for var index4 = split; index4 < arr.count; ++index4 {
            setP2.insert(arr[index4])
        }
        
        player1Cards = Array(setP1)
        player2Cards = Array(setP2)
        
       
//        for var index = 0; index < player1Cards.count; ++index {
//            print(player1Cards[index].valueForKey("id"))
//        }
//        
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
        
        
        var player1CardsString = ""
        var player2CardsString = ""
        
        for var index = 0; index < player1Cards.count; ++index {
            if index == (player1Cards.count-1){
                player1CardsString += String(player1Cards[index].valueForKey("id") as? Int)
            }else{
                player1CardsString += String(player1Cards[index].valueForKey("id") as? Int) + ","
            }
            
        }
        
        for var index2 = 0; index2 < player2Cards.count; ++index2 {
            if index2 == (player2Cards.count-1){
                player2CardsString += String(player2Cards[index2].valueForKey("id") as? Int)
            }else{
                player2CardsString += String(player2Cards[index2].valueForKey("id") as? Int) + ","
            }
            
        }
        
        print(player1CardsString)
        print(player2CardsString)
        
        
        
        
        var newGame = NSEntityDescription.insertNewObjectForEntityForName("Game", inManagedObjectContext: context)
        
        
        
        //set Values
        //cardSet:
        newGame.setValue(setID, forKey: "cardset")
        newGame.setValue(cpuDifficulty, forKey: "difficulty")
        newGame.setValue(0, forKey: "laps")
        newGame.setValue(numberLaps, forKey: "maxLaps")
        newGame.setValue(gameTime, forKey: "maxTime")
        newGame.setValue(playerOneNameVar, forKey: "player1")
        newGame.setValue(player1CardsString, forKey: "player1Cards")
        newGame.setValue(playerTwoNameVar, forKey: "player2")
        newGame.setValue(player2CardsString, forKey: "player2Cards")
        newGame.setValue(0.0, forKey: "time")
        newGame.setValue(whoStarts, forKey: "turn")
        
        
        do {
            try context.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        /*
        yoo
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