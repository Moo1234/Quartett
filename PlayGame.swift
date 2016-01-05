//
//  PlayGame.swift
//  Quartett
//
//  Created by Moritz Martin on 27.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PlayGame: UIViewController{

    
    //GUI-Elements
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pickUpCard: UIButton!
    @IBOutlet weak var showCard: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardInfo: UITextView!
    
    
    
    //Vars
    var game = [NSManagedObject]()
    var cardsetID: Int = -1
    var cardset = [NSManagedObject]()
    var difficulty: Int = -1
    var currentLap: Int = 0
    var maxLaps: Int = -1
    var maxTime: Double = -1.0
    var p1Name: String = ""
    var p1Cards: String = ""
    
    var cards = [NSManagedObject]()
    var cpuCards: String = ""
    var turn: Bool = true
    var nextCard: Int = -1

    var card = [NSManagedObject]()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadGame()
        loadCardset()
        showCard.hidden = true
        print("cardset: " , cardsetID, "\n diff: " , difficulty, "\n maxLaps: ",maxLaps, "\n maxTime:", maxTime, "\n p1name: ", p1Name, "\n p1Cards: ", p1Cards, "\n cpuCards", cpuCards, "\n turn", turn)
        
        
    
        
        //Timer
        //var currentTime = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func pickUpCardPressed(sender: AnyObject) {
    
        showCard.hidden = false
        showCard.layer.borderWidth = 3
        showCard.layer.borderColor = UIColor.blackColor().CGColor
        showCard.layer.cornerRadius = 10
        
        var p1CardsString = stringToArrayString(p1Cards)
        
        loadNextCard(Int(p1CardsString[0])!)
        
        cardImage.image = UIImage(named: card[0].valueForKey("image") as! String!)
        cardInfo.text = card[0].valueForKey("info") as! String!
        //self.cardImage.image = UIImage(named: "rib")
    }
    
    
    //******************************************
    //DB-Opertions
    //START
    
    //Loads Game-Object and fills Vars
    func loadGame(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Game")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            game =  results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        cardsetID = game[0].valueForKey("cardset") as! Int!
        difficulty = game[0].valueForKey("difficulty") as! Int!
        maxLaps = game[0].valueForKey("maxLaps") as! Int!
        maxTime = game[0].valueForKey("maxTime") as! Double!
        p1Name = game[0].valueForKey("player1") as! String!
        p1Cards = game[0].valueForKey("player1Cards") as! String!
        cpuCards = game[0].valueForKey("player2Cards") as! String!
        turn = game[0].valueForKey("turn") as! Bool!
        
    }
    
    
    func loadCardset(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", cardsetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cardset = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func loadNextCard(currentCard: Int){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", currentCard)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            card = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        

        
    }

    
    //******************************************
    //DB-Operations
    //END
    
    
    //Convert String to Array(String)
    func stringToArrayString(x:String) -> [String]{
        let toArray = x.componentsSeparatedByString(",")
        
        return toArray
    }

    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */





//
//    func loadCardsFromCardset(cardIDs: [String]){
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "Card")
//
//        do {
//            let results =
//            try managedContext.executeFetchRequest(fetchRequest)
//            cardArrayTemp =  results as! [NSManagedObject]
//
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//
//        for var index = 0; index < cardIDs.count; ++index {
//            for var index2 = 0; index2 < cardArrayTemp.count; ++index2 {
//
//                if Int(cardIDs[index]) == cardArrayTemp[index2].valueForKey("id") as! Int{
//                    cardArraySet.insert(cardArrayTemp[index2])
//
//                }
//            }
//        }
//    }


}
