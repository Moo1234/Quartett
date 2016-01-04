//
//  PlayGame.swift
//  Quartett
//
//  Created by Moritz Martin on 27.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class PlayGame: UIViewController {

    //GUI-Elements
    @IBOutlet weak var pickUpCard: UIButton!
    
    
    
    
    
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
    
    var cpuCards: String = ""
    var turn: Bool = true
    
    
    //ypóo
    
    //
    //Testvariablen so lange noch kein richtiges SpielObjekt erstellt werden kann!
    //Später muss halt dann statt cardset spiel geladen werden und die vars werden durch das beschrieben
    //Begin
    //**************
    
    var cpuDif: Int = 1
    var numberLaps: Int = 10
    var playerOneNameVar: String = "player1"
    //  maxTime
    //  maxLaps
    var playerOneCards = [NSManagedObject]()
    var gameTime: Double = 600.0
    var whostarts: Bool = true
    var cardsetArray = [NSManagedObject]()
    
    
    func loadCardset(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cardsetArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    
    //*************
    //End
    //Testvariablen so lange noch kein richtiges SpielObjekt erstellt werden kann!
    //
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()
        
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
    }
    
    
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
