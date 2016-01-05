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

class PlayGame: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource{

    
    //GUI-Elements
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pickUpCard: UIButton!
    @IBOutlet weak var showCard: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardInfo: UITextView!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
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
    var p1CardsArray = [NSManagedObject]()
    var cpuCardsArray = [NSManagedObject]()
    
    var cards = [NSManagedObject]()
    var cpuCards: String = ""
    var turn: Bool = true
    var nextCard: Int = -1

    var currCard = [NSManagedObject]()

    var attributes = [NSManagedObject]()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadGame()
        loadCardset()
        loadAttribute()
        let p1CardsString = stringToArrayString(p1Cards)
        let cpuCardsString = stringToArrayString(cpuCards)
        p1CardsArray = loadCards(p1CardsString)
        cpuCardsArray = loadCards(cpuCardsString)
        
    
        
        
        
        showCard.hidden = true
        

        //Timer
        //var currentTime = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.attributes.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let atCell = collectionView.dequeueReusableCellWithReuseIdentifier("atCell", forIndexPath: indexPath) as! GameAttributesCollectionViewCell
        let attribute = attributes[indexPath.row]
        

        atCell.layer.borderWidth = 2
        atCell.layer.borderColor = UIColor.blackColor().CGColor
        atCell.layer.cornerRadius = 10
        
        let values = p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        
        atCell.valueLabel?.text = values![indexPath.row]
        atCell.nameLabel?.text = attribute.valueForKey("name") as? String
        
       
        
        
        return atCell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let cellsHeight = CGFloat(Int((p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",").count)!) / 2)
    
        return CGSizeMake((collectionView.bounds.size.width)/2, collectionView.bounds.size.height/cellsHeight)
    
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let values = p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        print("P1 :" , values![indexPath.row])
        let cpuValues = cpuCardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        
        print("CPU: ", cpuValues![indexPath.row])
        
    }

    
    
    
    
    @IBAction func pickUpCardPressed(sender: AnyObject) {
    
        showCard.hidden = false
        showCard.layer.borderWidth = 3
        showCard.layer.borderColor = UIColor.blackColor().CGColor
        cardNameLabel.layer.cornerRadius = 10
        cardImage.layer.cornerRadius = 10
        cardInfo.layer.cornerRadius = 10
        showCard.layer.cornerRadius = 10
        
        var p1CardsString = stringToArrayString(p1Cards)
        
        loadNextCard(Int(p1CardsString[0])!)
        
        cardImage.image = UIImage(named: currCard[0].valueForKey("image") as! String!)
        cardInfo.text = currCard[0].valueForKey("info") as! String!
        cardNameLabel.text = currCard[0].valueForKey("name") as! String!
        
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
            currCard = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    func loadAttribute(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Attribute")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "cardset == %d", cardsetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            attributes = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    func loadCards(arr:[String]) -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        var returnArr = [NSManagedObject]()
        // filters cards from specific cardset
        
        let firstp = Int(arr[0])!
        
        var predicate = NSPredicate(format: "id == %d",firstp)
        for var index = 1; index < arr.count; ++index{
            let predicate2 = NSPredicate(format: "id == %d", Int(arr[index])!)
            predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [predicate, predicate2])
        }
        
        
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            returnArr = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    
        return returnArr
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
