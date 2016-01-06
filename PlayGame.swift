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
    
    //picked up card
    let container = UIView()
    @IBOutlet var showCardBack: UIView!
    @IBOutlet var showCard: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardInfo: UITextView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //View to compare valuse
    @IBOutlet weak var compareView: UIView!
    @IBOutlet weak var winLoseLabel: UILabel!
    @IBOutlet weak var cpuAttLabel: UILabel!
    @IBOutlet weak var p1AttLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
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
    var drawStack = [NSManagedObject]()
    
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
        self.container.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        self.view.addSubview(container)
        
        self.container.addSubview(self.showCardBack)
        
        container.hidden = true
        showCard.hidden = true
        showCardBack.hidden = true
        
        

        //Timer
        //var currentTime = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //******************************************
    //Collection View Operations
    //START
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(turn){
            collectionView.userInteractionEnabled = true
        }else{
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("cpuTurn"), userInfo: nil, repeats: false)
        }
        return self.attributes.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let atCell = collectionView.dequeueReusableCellWithReuseIdentifier("atCell", forIndexPath: indexPath) as! GameAttributesCollectionViewCell
        let attribute = attributes[indexPath.row]

        atCell.layer.borderWidth = 2
        atCell.layer.borderColor = UIColor.blackColor().CGColor
        atCell.layer.cornerRadius = 10
        atCell.backgroundColor = UIColor.whiteColor()
        
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
        collectionView.userInteractionEnabled = false
        print(indexPath)
        print("..." , NSIndexPath(forRow: 0, inSection: 0))
        
        let values = p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        print("P1 :" , values![indexPath.row])
        let cpuValues = cpuCardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        
        print("CPU: ", cpuValues![indexPath.row])
        let condition: Bool = (attributes[indexPath.row].valueForKey("condition") as? Bool!)!
        

        var timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: Selector("dismissAlert"), userInfo: nil, repeats: false)

        
        compareView.hidden = false
        compareView.backgroundColor = UIColor.grayColor()
        compareView.layer.cornerRadius = 10
        
        p1AttLabel.text = values![indexPath.row]
        cpuAttLabel.text = cpuValues![indexPath.row]
        
        //Draw
        if(values![indexPath.row] == cpuValues![indexPath.row]){
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
            cell.backgroundColor = UIColor.orangeColor()
            drawOperations()
            
        }else if(condition){
//            print("P1: \(values![indexPath.row]) P2: \(cpuValues![indexPath.row])")
            if(values![indexPath.row] > cpuValues![indexPath.row]){
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                cell.backgroundColor = UIColor.greenColor()
                if(!turn){
                    winOperations()
                    turn = true
                    turnLabel.hidden = false
                    turnLabel.text = "Du bist an der Reihe!"
                }else{
                    winOperations()
                }
            }else{
                // 6 gegen 16 oder 31 gewinnt noch manchmal???
//                print(values![indexPath.row] > cpuValues![indexPath.row] , ";" , values![indexPath.row] , ":" , cpuValues![indexPath.row])
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                cell.backgroundColor = UIColor.redColor()
                if(!turn){
                    looseOperations()
                }else{
                    looseOperations()
                    turn = false
                    turnLabel.hidden = false
                    turnLabel.text = "Der Gegner ist an der Reihe!"
                }
            }
        }else{
            print("CPU KHDJKHDKDHKJHDKJDHJD ")
            if(values![indexPath.row] < cpuValues![indexPath.row]){
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                cell.backgroundColor = UIColor.greenColor()
                winOperations()
                if(!turn){
                    winOperations()
                }else{
                    looseOperations()
                }
            }else{
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                cell.backgroundColor = UIColor.redColor()
                if(!turn){
                    looseOperations()
                }else{
                    winOperations()
                }
            }
        }
        
    }

    
    //******************************************
    //Collection-View Operations
    //END
    
    
    //******************************************
    //IBActions 
    //START
    
    @IBAction func pickUpCardPressed(sender: AnyObject) {
        gamestart()
        
    }
    
    //******************************************
    //IBActions
    //END
    
   
    
    
    

    //******************************************
    //Functions
    //START
    
    
    func winOperations(){
        print("cool")
        winLoseLabel.text = "Dein Wert ist höher!"
        p1AttLabel.textColor = UIColor.greenColor()
        p1AttLabel.layer.borderWidth = 3
        p1AttLabel.backgroundColor = UIColor.whiteColor()
        p1AttLabel.layer.borderColor = UIColor.greenColor().CGColor
        cpuAttLabel.textColor = UIColor.redColor()
        cpuAttLabel.layer.borderWidth = 3
        cpuAttLabel.backgroundColor = UIColor.whiteColor()
        cpuAttLabel.layer.borderColor = UIColor.redColor().CGColor
        
        //print(p1CardsArray)
        while(drawStack.count > 0){
            p1CardsArray.append(drawStack[0])
            drawStack.removeFirst()
        }
        p1CardsArray.append(p1CardsArray[0])
        p1CardsArray.append(cpuCardsArray[0])
        p1CardsArray.removeAtIndex(0)
        cpuCardsArray.removeAtIndex(0)
        //print(p1CardsArray)

        
    }
    func looseOperations(){
        
        print("verloren")
    
        winLoseLabel.text = "Dein Wert ist kleiner!"
        p1AttLabel.textColor = UIColor.redColor()
        p1AttLabel.layer.borderWidth = 3
        p1AttLabel.backgroundColor = UIColor.whiteColor()
        p1AttLabel.layer.borderColor = UIColor.redColor().CGColor
        cpuAttLabel.textColor = UIColor.greenColor()
        cpuAttLabel.layer.borderWidth = 3
        cpuAttLabel.backgroundColor = UIColor.whiteColor()
        cpuAttLabel.layer.borderColor = UIColor.greenColor().CGColor
        
        while(drawStack.count > 0){
            cpuCardsArray.append(drawStack[0])
            drawStack.removeFirst()
        }
        cpuCardsArray.append(p1CardsArray[0])
        cpuCardsArray.append(cpuCardsArray[0])
        cpuCardsArray.removeAtIndex(0)
        p1CardsArray.removeAtIndex(0)
        
    }
    func drawOperations(){
        print("unentschieden")
        winLoseLabel.text = "Eure Werte sind gleich"
        p1AttLabel.textColor = UIColor.orangeColor()
        p1AttLabel.layer.borderWidth = 3
        p1AttLabel.backgroundColor = UIColor.whiteColor()
        p1AttLabel.layer.borderColor = UIColor.orangeColor().CGColor
        cpuAttLabel.textColor = UIColor.orangeColor()
        cpuAttLabel.layer.borderWidth = 3
        cpuAttLabel.backgroundColor = UIColor.whiteColor()
        cpuAttLabel.layer.borderColor = UIColor.orangeColor().CGColor
        
        drawStack.append(p1CardsArray[0])
        drawStack.append(cpuCardsArray[0])
        cpuCardsArray.removeAtIndex(0)
        p1CardsArray.removeAtIndex(0)
        
    }
    
    
    
    func cpuTurn(){
        let values = cpuCardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        var choice: Int = -1
        if(difficulty == 1){
            print(values)
            choice = Int(arc4random())  % values!.count
        }else if(difficulty == 2){
            choice = Int(arc4random())  % values!.count
        }else{
            
        }
        print(choice)
        collectionView.delegate?.collectionView!(self.collectionView, didSelectItemAtIndexPath: NSIndexPath(forRow: choice, inSection: 0))
    }
    
    func gamestart(){
        showCard.hidden = false
        showCardBack.hidden = false
        container.hidden = false
        UIView.transitionFromView(showCardBack, toView: showCard, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        
        showCard.layer.borderWidth = 3
        showCard.layer.borderColor = UIColor.blackColor().CGColor
        cardNameLabel.layer.cornerRadius = 10
        cardImage.layer.cornerRadius = 10
        cardInfo.layer.cornerRadius = 10
        showCard.layer.cornerRadius = 10
        
        
        cardImage.image = UIImage(named: p1CardsArray[0].valueForKey("image") as! String!)
        cardInfo.text = p1CardsArray[0].valueForKey("info") as! String!
        cardNameLabel.text = p1CardsArray[0].valueForKey("name") as! String!
        
    }
    
    
    func gameContinue(){
        
        if p1CardsArray.count > 0 && cpuCardsArray.count > 0 {
            
            cardImage.image = UIImage(named: p1CardsArray[0].valueForKey("image") as! String!)
            cardInfo.text = p1CardsArray[0].valueForKey("info") as! String!
            cardNameLabel.text = p1CardsArray[0].valueForKey("name") as! String!
            
            showCard.hidden = false
            showCardBack.hidden = false
            
//            let views = (frontView: self.showCard, backView: self.showCardBack)
//            let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
//            UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions, animations: {
//                // remove the front object...
//                views.frontView.removeFromSuperview()
//                
//                // ... and add the other object
//                self.container.addSubview(views.backView)
//                
//                
//                }, completion: { finished in
//                    let views2 = (frontView: self.showCardBack, backView: self.showCard)
//                    let transitionOptions2 = UIViewAnimationOptions.TransitionFlipFromRight
//                    UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions2, animations: {
//                        // remove the front object...
//                        views2.backView.removeFromSuperview()
//                        
//                        // ... and add the other object
//                        self.container.addSubview(views2.frontView)
//                        
//                        
//                        }, completion: { finished in
//                            // any code entered here will be applied
//                            // .once the animation has completed
//                    })
//            })
            
//            UIView.transitionFromView(showCard, toView: showCardBack, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
//            UIView.transitionFromView(showCardBack, toView: showCard, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            collectionView.reloadData()
        }
        
    }
    
    func dismissAlert()
    {
        // Dismiss the alert from here
        compareView.hidden = true
        turnLabel.hidden = true
        currentLap++
        print("Anzahl P1 Karten " , p1CardsArray.count)
        print("Anzahl P2 Karten " , cpuCardsArray.count)
        if(p1CardsArray.count > 0 && cpuCardsArray.count > 0 && currentLap < maxLaps){
            gameContinue()
        }
        else{
            if(p1CardsArray.count > cpuCardsArray.count){
                print("Win Game")
            }else if(p1CardsArray.count == cpuCardsArray.count){
                print("Draw Game")
            }
            else{
                print("Loose Game")
            }
        }
        
    }

    //Convert String to Array(String)
    func stringToArrayString(x:String) -> [String]{
        let toArray = x.componentsSeparatedByString(",")
        
        return toArray
    }
    
    //******************************************
    //Functions
    //END
    
    
    
    
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
        print(p1Cards)
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
        
//        let firstp = Int(arr[0])!
        
//        var predicate = NSPredicate(format: "id == %d",firstp)
        for var index = 0; index < arr.count; ++index{
            let predicate2 = NSPredicate(format: "id == %d", Int(arr[index])!)
//            predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [predicate, predicate2])
        
        
        
            fetchRequest.predicate = predicate2
        
            do {
                let results =
                try managedContext.executeFetchRequest(fetchRequest)
                let returnArr2 = results as! [NSManagedObject]
                returnArr.append(returnArr2[0])
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        return returnArr
    }


    
    //******************************************
    //DB-Operations
    //END
    
    
    
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
