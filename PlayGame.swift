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
import AudioToolbox

class PlayGame: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource{
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressView2: UIProgressView!
    @IBOutlet weak var progressView3: UIProgressView!
    @IBOutlet weak var progressView4: UIProgressView!
    @IBOutlet weak var progressView5: UIProgressView!
    
    //GUI-Elementss
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pickUpCard: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //picked up card
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
    var everyCardArray = [NSManagedObject]()
    var drawStack = [NSManagedObject]()
    
    var cards = [NSManagedObject]()
    var cpuCards: String = ""
    var turn: Bool = true
    var nextCard: Int = -1
    
    var currCard = [NSManagedObject]()

    var attributes = [NSManagedObject]()
    
    var currentTime: Double = 0.0
    var cpuSpeed: Double = 2.0
    var showAlertTime: Double = 4.0
    
    var index = NSIndexPath(forRow: 0, inSection: 0)
    
    // Views for animations
    let container = UIView()
    var front = UIView()
    var back = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadGame()
        if (cardsetID == 3 || cardsetID == 4){
            backgroundImage.image = UIImage(named: "tisch")
        }
        
        loadCardset()
        loadAttribute()
        let p1CardsString = stringToArrayString(p1Cards)
        let cpuCardsString = stringToArrayString(cpuCards)
        let everyCard = stringToArrayString((p1Cards + "," + cpuCards))
        p1CardsArray = loadCards(p1CardsString)
        cpuCardsArray = loadCards(cpuCardsString)
        everyCardArray = loadCards(everyCard)
        cardInfo.selectable = false
        self.container.frame = CGRect(x: 0, y: 63, width: view.frame.size.width, height: view.frame.size.height-63)
        self.view.addSubview(container)
        
        self.container.addSubview(self.showCardBack)
        self.container.addSubview(self.front)
        if(currentLap == 0){
            container.hidden = true
            showCard.hidden = true
            showCardBack.hidden = true
        }else{
            print("Resume Game")
            gamestart()
            
            let bar = Float(p1CardsArray.count) / Float(p1CardsArray.count+cpuCardsArray.count)
            progressView.setProgress(bar, animated: true)
            progressView2.setProgress(bar, animated: true)
            progressView3.setProgress(bar, animated: true)
            progressView4.setProgress(bar, animated: true)
            progressView5.setProgress(bar, animated: true)
        }
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timer", userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //******************************************
    //Collection View Operations
    //START
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(turn){
            collectionView.userInteractionEnabled = true
        }else{
            NSTimer.scheduledTimerWithTimeInterval(cpuSpeed, target: self, selector: Selector("cpuTurn"), userInfo: nil, repeats: false)
        }
        return self.attributes.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var iconString: String = ""
        let atCell = collectionView.dequeueReusableCellWithReuseIdentifier("atCell", forIndexPath: indexPath) as! GameAttributesCollectionViewCell
        let attribute = attributes[indexPath.row]
        
        atCell.layer.borderWidth = 2
        atCell.layer.borderColor = UIColor.blackColor().CGColor
        atCell.layer.cornerRadius = 10
        atCell.backgroundColor = UIColor.whiteColor()
        if(p1CardsArray.count > 0){
            let values = p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
            
            
            atCell.valueLabel?.text = values![indexPath.row]
            atCell.nameLabel?.text = attribute.valueForKey("name") as? String
            
            
            iconString = (attribute.valueForKey("icon") as? String)!
            
            if iconString == "" {
                if((attribute.valueForKey("condition") as? Bool)!){
                    atCell.attributeIcon?.image = UIImage(named: "ButtonUp")
                }else{
                    atCell.attributeIcon?.image = UIImage(named: "ButtonDown")
                }
            }else{
                atCell.attributeIcon?.image = UIImage(named: iconString)
                
            }
            if attribute.valueForKey("unit") as? String != ""{
                
                atCell.attributeUnitLabel?.text = attribute.valueForKey("unit") as? String
            }else{
                atCell.attributeUnitLabel?.text = "n.A."
            }
            
            cardInfo.contentOffset = CGPoint(x: 0, y: 7)
        }
        return atCell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let cellsHeight = CGFloat(Int((p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",").count)!) / 2)
        let collectionWidth = collectionView.bounds.size.width
        let collectionHeight = collectionView.bounds.size.height
        return CGSizeMake(collectionWidth/2, collectionHeight/3)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.userInteractionEnabled = false
        
        let values = p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        print("P1 :" , values![indexPath.row])
        let cpuValues = cpuCardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        
        print("CPU: ", cpuValues![indexPath.row])
        let condition: Bool = (attributes[indexPath.row].valueForKey("condition") as? Bool)!
 
        
        if(!turn){
            print("Indexpath" , indexPath.row)
            collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
            collectionView.layoutIfNeeded()
        }else{
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        }
        compareView.hidden = false
        compareView.backgroundColor = UIColor.grayColor()
        compareView.layer.cornerRadius = 10
        
        p1AttLabel.text = values![indexPath.row]
        cpuAttLabel.text = cpuValues![indexPath.row]
        
        //Draw
        if(Float(values![indexPath.row]) == Float(cpuValues![indexPath.row])){
            
            if(everyCardArray[0].valueForKey("values")?.componentsSeparatedByString(",").count < 7){
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                cell.backgroundColor = UIColor.orangeColor()
            }
            drawOperations()
            
        }else if(condition){
            //            print("P1: \(values![indexPath.row]) P2: \(cpuValues![indexPath.row])")
            if(Float(values![indexPath.row]) > Float(cpuValues![indexPath.row])){
                
                if(everyCardArray[0].valueForKey("values")?.componentsSeparatedByString(",").count < 7){
                    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                    cell.backgroundColor = UIColor.greenColor()
                    UIView.animateWithDuration(0.6 ,
                        animations: {
                            cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                        },
                        completion: { finish in
                            UIView.animateWithDuration(0.6){
                                cell.transform = CGAffineTransformIdentity
                            }
                    })
                }
                if(!turn){
                    winOperations()
                    turn = true
                    turnLabel.hidden = false
                    turnLabel.text = "Du bist an der Reihe!"
                }else{
                    winOperations()
                }
            }else{
                if(everyCardArray[0].valueForKey("values")?.componentsSeparatedByString(",").count < 7){
                    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                    cell.backgroundColor = UIColor.redColor()
                    UIView.animateWithDuration(0.6 ,
                        animations: {
                            cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                        },
                        completion: { finish in
                            UIView.animateWithDuration(0.6){
                                cell.transform = CGAffineTransformIdentity
                            }
                    })
                }
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
            if(Float(values![indexPath.row]) < Float(cpuValues![indexPath.row])){
                
                if(everyCardArray[0].valueForKey("values")?.componentsSeparatedByString(",").count < 7){
                    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                    cell.backgroundColor = UIColor.greenColor()
                    UIView.animateWithDuration(0.6 ,
                        animations: {
                            cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                        },
                        completion: { finish in
                            UIView.animateWithDuration(0.6){
                                cell.transform = CGAffineTransformIdentity
                            }
                    })
                }
                if(!turn){
                    winOperations()
                    turn = true
                    turnLabel.hidden = false
                    turnLabel.text = "Du bist an der Reihe!"
                }else{
                    winOperations()
                }
            }else{
                
                if(everyCardArray[0].valueForKey("values")?.componentsSeparatedByString(",").count < 7){
                    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GameAttributesCollectionViewCell
                    cell.backgroundColor = UIColor.redColor()
                    UIView.animateWithDuration(0.6 ,
                        animations: {
                            cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                        },
                        completion: { finish in
                            UIView.animateWithDuration(0.6){
                                cell.transform = CGAffineTransformIdentity
                            }
                    })
                }
                if(!turn){
                    looseOperations()
                }else{
                    looseOperations()
                    turn = false
                    turnLabel.hidden = false
                    turnLabel.text = "Der Gegner ist an der Reihe!"
                }
            }
        }
        
        NSTimer.scheduledTimerWithTimeInterval(showAlertTime, target: self, selector: Selector("dismissAlert"), userInfo: nil, repeats: false)
        
    }
    
    
    //******************************************
    //Collection-View Operations
    //END
    
    
    //******************************************
    //IBActions
    //START
    
    
    @IBAction func backButton(sender: AnyObject) {
        deleteObjectsFromEntity("Game")
        saveGame()
    }
    
    @IBAction func pickUpCardPressed(sender: AnyObject) {
        gamestart()
        
    }
    
    //******************************************
    //IBActions
    //END
    
    
    
    
    
    
    //******************************************
    //Functions
    //START
    
    
    func timer(){
        currentTime += 0.1
        if currentTime == maxTime{
            self.performSegueWithIdentifier("gameOver", sender:self)
            
        }
        
    }
    
    func winOperations(){
        print("winOperation")
        winLoseLabel.text = "Dein Wert ist besser!"
        if (cpuSpeed == 0.0) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            cpuSpeed = 2.0
            showAlertTime = 4.0
            
        }
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
        print("looseOperation")
        winLoseLabel.text = "Dein Wert ist schlechter!"
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
        print("drawOperation")
        winLoseLabel.text = "Eure Werte sind gleich"
        p1AttLabel.textColor = UIColor.orangeColor()
        p1AttLabel.layer.borderWidth = 3
        p1AttLabel.backgroundColor = UIColor.whiteColor()
        p1AttLabel.layer.borderColor = UIColor.orangeColor().CGColor
        cpuAttLabel.textColor = UIColor.orangeColor()
        cpuAttLabel.layer.borderWidth = 3
        cpuAttLabel.backgroundColor = UIColor.whiteColor()
        cpuAttLabel.layer.borderColor = UIColor.orangeColor().CGColor
        
        if(p1CardsArray.count > 1){
            drawStack.append(p1CardsArray[0])
            cpuCardsArray.removeAtIndex(0)
        }
        if(cpuCardsArray.count > 1){
            drawStack.append(cpuCardsArray[0])
            p1CardsArray.removeAtIndex(0)
        }
        if(cpuCardsArray.count == 1 && p1CardsArray.count == 1){
            self.performSegueWithIdentifier("gameOver", sender:self)
        }
    }
    
    
    
    func cpuTurn(){
        var values = everyCardArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        var values3 = cpuCardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        var averageValue = [Float] (count: (values?.count)!, repeatedValue: 0)
        var choice: Int = -1
        var minValue: Float = Float(values![0])!
        var minValueIndex: Int = 0
        var maxValue: Float = Float(values![0])!
        var maxValueIndex: Int = 0
        if(difficulty == 0){
            for var index = 0; index < averageValue.count; ++index{
                for var index1 = 0; index1 < everyCardArray.count; ++index1{
                    var values2 = everyCardArray[index1].valueForKey("values")?.componentsSeparatedByString(",")
                    averageValue[index] += Float(values2![index])!
                    
                }
                averageValue[index] /= (Float(everyCardArray.count))
                averageValue[index] = Float(values3![index])! / averageValue[index]
            }
            
            
            minValue = averageValue.minElement()!
            minValueIndex = averageValue.indexOf(minValue)!
            
            maxValue = averageValue.maxElement()!
            maxValueIndex = averageValue.indexOf(maxValue)!
            
            if ((attributes[minValueIndex].valueForKey("condition") as? Bool) == true  && (attributes[maxValueIndex].valueForKey("condition") as? Bool) == true ){
                choice = minValueIndex
            }else if((attributes[minValueIndex].valueForKey("condition") as? Bool) == false  && (attributes[maxValueIndex].valueForKey("condition") as? Bool) == false){
                choice = maxValueIndex
            }else{
                if maxValue > (1 / minValue){
                    choice = minValueIndex
                }else{
                    choice = maxValueIndex
                }
                
            }
        }else if(difficulty == 1){
            choice = Int(arc4random())  % values!.count
        }else{
            for var index = 0; index < averageValue.count; ++index{
                for var index1 = 0; index1 < everyCardArray.count; ++index1{
                    var values2 = everyCardArray[index1].valueForKey("values")?.componentsSeparatedByString(",")
                    averageValue[index] += Float(values2![index])!
                    
                }
                averageValue[index] /= (Float(everyCardArray.count))
                
                averageValue[index] = Float(values3![index])! / averageValue[index]
            }
            print(averageValue)
            minValue = averageValue.minElement()!
            minValueIndex = averageValue.indexOf(minValue)!
            
            maxValue = averageValue.maxElement()!
            maxValueIndex = averageValue.indexOf(maxValue)!
            
            if ((attributes[minValueIndex].valueForKey("condition") as? Bool) == true  && (attributes[maxValueIndex].valueForKey("condition") as? Bool) == true ){
                choice = maxValueIndex
            }else if((attributes[minValueIndex].valueForKey("condition") as? Bool) == false  && (attributes[maxValueIndex].valueForKey("condition") as? Bool) == false){
                choice = minValueIndex
            }else{
                if maxValue > (1 / minValue) {
                    choice = maxValueIndex
                }else{
                    choice = minValueIndex
                }
                
            }
            
        }
        index = NSIndexPath(forRow: choice, inSection: 0)
        collectionView.delegate?.collectionView!(self.collectionView, didSelectItemAtIndexPath: index)
        
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
            
            self.collectionView.reloadData()

            var views : (frontView: UIView, backView: UIView)
            if(self.front.superview != nil){
                views = (frontView: self.front, backView: self.back)
            }
            else {
                views = (frontView: self.back, backView: self.front)
            }
            UIView.transitionFromView(views.frontView, toView: views.backView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)

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
        
        let bar = Float(p1CardsArray.count) / Float(p1CardsArray.count+cpuCardsArray.count)
        progressView.setProgress(bar, animated: true)
        progressView2.setProgress(bar, animated: true)
        progressView3.setProgress(bar, animated: true)
        progressView4.setProgress(bar, animated: true)
        progressView5.setProgress(bar, animated: true)
        
        if(p1CardsArray.count > 0 && cpuCardsArray.count > 0 && currentLap < maxLaps){
            gameContinue()
        }
        else{
            self.performSegueWithIdentifier("gameOver", sender:self)
        }
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "gameOver"){
            
            let vc = segue.destinationViewController as! EndScreenViewController
            if (p1CardsArray.count > cpuCardsArray.count){
                vc.labelTxt = "Du hast gewonnen!"
                saveRanking(p1Name, rounds: currentLap, time: currentTime)
            }else if(p1CardsArray.count == cpuCardsArray.count){
                vc.labelTxt = "Unentschieden!"
            }else{
                vc.labelTxt = "Du hast verloren!"
            }
            deleteObjectsFromEntity("Game")
        }
    }
    
    
    //Convert String to Array(String)
    func stringToArrayString(x:String) -> [String]{
        let toArray = x.componentsSeparatedByString(",")
        
        return toArray
    }
    
    func objectToString(object: [NSManagedObject]) -> String{
        var cards = ""
        for var index = 0; index < object.count; index++ {
            cards += "\(object[index].valueForKey("id")!)"
            if(index < object.count - 1){
                cards += ","
            }
        }
        return cards
    }
    
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            cpuSpeed = 0.0
            showAlertTime = 0.5
        }
    }
    

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            cpuSpeed = 2.0
            showAlertTime = 4.0
            
        }
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
        currentLap = game[0].valueForKey("laps") as! Int
        maxLaps = game[0].valueForKey("maxLaps") as! Int!
        maxTime = game[0].valueForKey("maxTime") as! Double!
        p1Name = game[0].valueForKey("player1") as! String!
        p1Cards = game[0].valueForKey("player1Cards") as! String!
        cpuCards = game[0].valueForKey("player2Cards") as! String!
        currentTime = game[0].valueForKey("time") as! Double
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
    
    func saveRanking(player: String, rounds: Int, time: Double) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Ranking", inManagedObjectContext:managedContext)
        let newRanking = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        newRanking.setValue(player, forKey: "player")
        newRanking.setValue(rounds, forKey: "scoreRounds")
        newRanking.setValue(time, forKey: "scoreTime")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
    
    func saveGame() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Game", inManagedObjectContext:managedContext)
        let game = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        game.setValue(cardsetID, forKey: "cardset")
        game.setValue(difficulty, forKey: "difficulty")
        game.setValue(currentLap, forKey: "laps")
        game.setValue(maxLaps, forKey: "maxLaps")
        game.setValue(maxTime, forKey: "maxTime")
        game.setValue(p1Name, forKey: "player1")
        game.setValue(objectToString(p1CardsArray), forKey: "player1Cards")
        game.setValue("SinglePlayerGame", forKey: "player2")
        game.setValue(objectToString(cpuCardsArray), forKey: "player2Cards")
        game.setValue(currentTime, forKey: "time")
        game.setValue(turn, forKey: "turn")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
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
