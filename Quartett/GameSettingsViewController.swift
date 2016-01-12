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
    
    @IBOutlet weak var oneOrTwoPlayerOutlet: UISegmentedControl!
    @IBOutlet weak var setNumberOfRoundsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuSettingsOutlet: UISegmentedControl!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var setTimeOutlet: UISegmentedControl!
    @IBOutlet weak var cardSetIcon: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    
    
    @IBAction func openSetGalery(sender: AnyObject) {
    }
    //Vars
    var playerOneNameVar = ""
    var playerTwoNameVar = ""
    var cpuDifficulty = 0
    var numberLaps = 20
    var gameTime: NSTimeInterval = 600.0
    var setID: Int = 2
    var cardSetIconString = "CardSet3"
    var cardArray = [NSManagedObject]()
    var player1Cards = [NSManagedObject]()
    var player2Cards = [NSManagedObject]()
    var backID: Int = 0
    
    
    // Segment Control: CPU Settings
    @IBAction func cpuSettings(sender: AnyObject) {
        
        switch cpuSettingsOutlet.selectedSegmentIndex{
            
        case 0:
            cpuDifficulty = 0
        case 1:
            cpuDifficulty = 1
        case 2:
            cpuDifficulty = 2
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
        
        startButton.enabled = false
        
        playerOneName.delegate = self
        playerOneName.tag = 0
        playerTwoName.delegate = self
        playerTwoName.tag = 1
        
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        
        
        
        
        let modelName = UIDevice.currentDevice().modelName
        if modelName == "iPhone 4" || modelName == "iPhone 4s" {
            scrollView.contentSize.height = 800;
        }else if modelName == "iPhone 5" || modelName == "iPhone 5s" {
            scrollView.contentSize.height = 700
        }
        if(setID != -1){
            cardSetIcon.image = UIImage(named: cardSetIconString)
        }
        
        playerTwoName.hidden = true
        cpuLabel.hidden = false
        cpuSettingsOutlet.hidden = false
        
        if backID == 1{
            playerOneName.text = playerOneNameVar
            
            cpuSettingsOutlet.selectedSegmentIndex = cpuDifficulty
            
            if gameTime == 600.0{
                setTimeOutlet.selectedSegmentIndex = 0
            }else if gameTime == 1200.0{
                setTimeOutlet.selectedSegmentIndex = 1
            }else{
                setTimeOutlet.selectedSegmentIndex = 2
            }
            
            
            if numberLaps == 20{
                setNumberOfRoundsOutlet.selectedSegmentIndex = 0
            }else if numberLaps == 40{
                setNumberOfRoundsOutlet.selectedSegmentIndex = 1
            }else{
                setNumberOfRoundsOutlet.selectedSegmentIndex = 2
            }
            
            if playerTwoNameVar != ""{
                oneOrTwoPlayerOutlet.selectedSegmentIndex = 1
                playerTwoName.text = playerTwoNameVar
                playerTwoName.hidden = false
                cpuLabel.hidden = true
                cpuSettingsOutlet.hidden = true
                
            }
            
        }
        
        
        
        
        if playerOneNameVar != "" && setID != -1 && oneOrTwoPlayerOutlet.selectedSegmentIndex == 0{
            startButton.enabled = true
        }
        
        if oneOrTwoPlayerOutlet.selectedSegmentIndex == 1 && playerOneNameVar != "" && playerTwoNameVar != "" && setID != -1{
            startButton.enabled = true
        }
        
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
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    //Hide Keyboard after typing
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 0{
            playerOneNameVar = textField.text!
        }else{
            playerTwoNameVar = textField.text!
        }
        
        self.view.endEditing(true)
        
        if playerOneNameVar != "" && setID != -1 && oneOrTwoPlayerOutlet.selectedSegmentIndex == 0{
            startButton.enabled = true
        }
        
        if oneOrTwoPlayerOutlet.selectedSegmentIndex == 1 && playerOneNameVar != "" && playerTwoNameVar != "" && setID != -1{
            startButton.enabled = true
        }
        
        return false
    }
    
    
    //hide or show textfield player2
    @IBAction func oneOrTwoPlayer(sender: AnyObject) {
        
        if(playerTwoName.hidden == true){
            playerTwoName.hidden = false
            cpuLabel.hidden = true
            cpuSettingsOutlet.hidden = true
            if playerTwoNameVar == ""{
                startButton.enabled = false
            }
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
        
        var randomNum: Int = Int(arc4random())  % arr.count
        var randomNum2: Int = Int(arc4random())  % arr.count
        var temp: NSManagedObject
        
        //shuffle
        for var index = 0; index < shuffle; ++index {
            randomNum = Int(arc4random()) % arr.count
            randomNum2 = Int(arc4random()) % arr.count
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
        var temp: Int  = -1
//        print(setID)
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        loadCardSetWithSetID()
        shuffleCards(cardArray)
        
        if playerTwoName.hidden == false{
            
            cpuDifficulty = -1
        }else{
            playerTwoNameVar = "SinglePlayerGame"
        }
        
        let whoStarts = true
        
        
        var player1CardsString = ""
        var player2CardsString = ""
        
        for var index = 0; index < player1Cards.count; ++index {
            if index == (player1Cards.count-1){
                temp = Int((player1Cards[index].valueForKey("id") as? Int)!)
                player1CardsString += String(temp)
            }else{
                temp = Int((player1Cards[index].valueForKey("id") as? Int)!)
                player1CardsString += String(temp) + ","
            }
            
        }
        
        for var index2 = 0; index2 < player2Cards.count; ++index2 {
            if index2 == (player2Cards.count-1){
                temp = Int((player2Cards[index2].valueForKey("id") as? Int)!)
                player2CardsString += String(temp)
            
            }else{
                temp = Int((player2Cards[index2].valueForKey("id") as? Int)!)
                player2CardsString += String(temp) + ","
            }
            
        }
        deleteObjectsFromEntity("Game")
        
        let newGame = NSEntityDescription.insertNewObjectForEntityForName("Game", inManagedObjectContext: context)
        
        
        //Set Values
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
        
        
        if playerTwoNameVar != "SinglePlayerGame" {
            self.performSegueWithIdentifier("multiPlayer", sender:self)
        }else{
            self.performSegueWithIdentifier("singlePlayer", sender:self)
        }
        
    }
    
    func deleteObjectsFromEntity(entity: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "chooseGaleryButton"){
            let vc = segue.destinationViewController as! ChooseGalery
            vc.p1NameTemp = playerOneNameVar
            vc.difficultyTemp = cpuDifficulty
            vc.timeTemp = gameTime
            vc.roundsTemp = numberLaps
            vc.p2NameTemp = playerTwoNameVar
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
