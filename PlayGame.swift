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

    //START
    //Testvariablen so lange noch kein richtiges SpielObjekt erstellt werden kann!
    //**************
    
    var cpuDif: Int = 1
    var numberLaps: Int = 10
    var playerOneNameVar: String = "player1"
//  maxTime
//  maxLaps
    var playerOneCards = [NSManagedObject]()
    var cpuCards = [NSManagedObject]()
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
    //Testvariablen so lange noch kein richtiges SpielObjekt erstellt werden kann! 
    //ENDE
    
    
    var cards:String = ""
    var cardIDsArray: [String] = []
    
    
    var cardArraySet = Set<NSManagedObject>()
    var cardArrayTemp = [NSManagedObject]()
    
    @IBOutlet weak var pickUpCard: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCardset()
        cards = cardsetArray[0].valueForKey("cards") as! String!
        cardIDsArray = stringToArrayString(cards)
        loadCardsFromCardset(cardIDsArray)
        let cardArray = Array(cardArraySet)
        
        shuffleCards(cardArray)
        
        
        
       
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func pickUpCardPressed(sender: AnyObject) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadCardsFromCardset(cardIDs: [String]){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cardArrayTemp =  results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        for var index = 0; index < cardIDs.count; ++index {
            for var index2 = 0; index2 < cardArrayTemp.count; ++index2 {
            
                if Int(cardIDs[index]) == cardArrayTemp[index2].valueForKey("id") as! Int{
                    cardArraySet.insert(cardArrayTemp[index2])
                    
                }
            }
        }

    }

    
    //Convert String to Array(String)
    func stringToArrayString(x:String) -> [String]{
        let toArray = x.componentsSeparatedByString(",")
    
        return toArray
    }
    
    

    //cardshuffle Algo
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
        
        playerOneCards = Array(setP1)
        cpuCards = Array(setP2)

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

