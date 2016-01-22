//
//  MultiPlayGame.swift
//  Quartett
//
//  Created by Moritz Martin on 12.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class MultiPlayGame: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var p2CardInfo: UITextView!
    @IBOutlet weak var p2CardImage: UIImageView!
    @IBOutlet weak var p2CollectionView: UICollectionView!
    @IBOutlet weak var p2NameLabel: UILabel!
    @IBOutlet weak var p2InfoButton: UIButton!
    @IBOutlet weak var p2Back: UIImageView!
    
    
    @IBOutlet weak var p1Back: UIImageView!
    @IBOutlet weak var p1CardImage: UIImageView!
    @IBOutlet weak var p1CardInfo: UITextView!
    @IBOutlet weak var p1CollectionView: UICollectionView!
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p1InfoButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    @IBAction func p2InfoButtonPressed(sender: AnyObject) {
        if p2CardInfo.hidden == true{
            p2CardInfo.hidden = false
            p2CardImage.hidden = true
        }else{
            p2CardInfo.hidden = true
            p2CardImage.hidden = false
        }
        
        
        
    }
    
    @IBAction func p1InfoButtonPressed(sender: AnyObject) {
        if p1CardInfo.hidden == true{
            p1CardInfo.hidden = false
            p1CardImage.hidden = true
        }else{
            p1CardInfo.hidden = true
            p1CardImage.hidden = false
            
        }
        
        
        
    }
        
    
    
    // vars
    var game = [NSManagedObject]()
    var cardsetID: Int = -1
    var cardset = [NSManagedObject]()
    var difficulty: Int = -1
    var currentLap: Int = 0
    var maxLaps: Int = -1
    var maxTime: Double = -1.0
    var p1Name: String = ""
    var p2Name: String = ""
    var p1Cards: String = ""
    var p2Cards: String = ""
    var p1CardsArray = [NSManagedObject]()
    var p2CardsArray = [NSManagedObject]()
    var drawStack = [NSManagedObject]()
    
    var turn: Bool = true
    
    var currentTime: Double = 0.0
    var showAlertTime: Double = 4.0
    
    var attributes = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        p2CardImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2CardInfo.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2CollectionView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2NameLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2InfoButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2Back.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "appMovedToBackground", name: UIApplicationWillResignActiveNotification, object: nil)
        
        loadGame()
        
        cardset = Data().loadCardset(cardsetID)
        attributes = Data().loadAttributes(cardsetID)
        let p1CardsString = Data().stringToArrayString(p1Cards)
        let p2CardsString = Data().stringToArrayString(p2Cards)
        p1CardsArray = Data().loadCards(p1CardsString)
        p2CardsArray = Data().loadCards(p2CardsString)
        p1CardInfo.selectable = false
        p2CardInfo.selectable = false
        
        showCard()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.userInteractionEnabled = true
        return self.attributes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(collectionView == self.p1CollectionView){
            var iconString: String = ""
            let atCell = collectionView.dequeueReusableCellWithReuseIdentifier("p1Cell", forIndexPath: indexPath) as! MultiplayerAttributeCollectionViewCell1
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
                
                p1CardInfo.contentOffset = CGPoint(x: 0, y: 7)
            }
            return atCell
        }else{
            var iconString: String = ""
            let atCell = collectionView.dequeueReusableCellWithReuseIdentifier("p2Cell", forIndexPath: indexPath) as! MultiplayerAttributeCollectionViewCell2
            let attribute = attributes[indexPath.row]
            
            atCell.layer.borderWidth = 2
            atCell.layer.borderColor = UIColor.blackColor().CGColor
            atCell.layer.cornerRadius = 10
            atCell.backgroundColor = UIColor.whiteColor()
            if(p1CardsArray.count > 0){
                let values = p2CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
                
                
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
                
                p1CardInfo.contentOffset = CGPoint(x: 0, y: 7)
            }
            return atCell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //        let cellsHeight = CGFloat(Int((p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",").count)!) / 2)
        let collectionWidth = collectionView.bounds.size.width
        let collectionHeight = collectionView.bounds.size.height
        return CGSizeMake(collectionWidth/2, collectionHeight/3)
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.userInteractionEnabled = false
        
        let p1values = p1CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        let p2Values = p2CardsArray[0].valueForKey("values")?.componentsSeparatedByString(",")
        
        let condition: Bool = (attributes[indexPath.row].valueForKey("condition") as? Bool)!
        
        p1CardImage.hidden = false
        p2CardImage.hidden = false
        p1CollectionView.hidden = false
        p2CollectionView.hidden = false
        p1NameLabel.hidden = false
        p2NameLabel.hidden = false
//        p1CardInfo.hidden = false
//        p2CardInfo.hidden = false
        p1InfoButton.hidden = false
        p2InfoButton.hidden = false
        
        
        if (turn){
            p2Back.hidden = true
        }else{
            p1Back.hidden = true
        }
        
       
        
        p1CollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        p2CollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        
        let p1Cell = p1CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell1
        let p2Cell = p2CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell2
        if(Float(p1values![indexPath.row]) == Float(p2Values![indexPath.row])){
            p1Cell.backgroundColor = UIColor.orangeColor()
            p2Cell.backgroundColor = UIColor.orangeColor()
            drawOperations()
            
        }else if(condition){
            //            print("P1: \(values![indexPath.row]) P2: \(cpuValues![indexPath.row])")
            if(Float(p1values![indexPath.row]) > Float(p2Values![indexPath.row])){
                p1Cell.backgroundColor = UIColor.greenColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p1Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p1Cell.transform = CGAffineTransformIdentity
                        }
                })
                p2Cell.backgroundColor = UIColor.redColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p2Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p2Cell.transform = CGAffineTransformIdentity
                        }
                })
                if(!turn){
                    turn = true
                }
                p1winOperations()
            }else{
                p1Cell.backgroundColor = UIColor.redColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p1Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p1Cell.transform = CGAffineTransformIdentity
                        }
                })
                p2Cell.backgroundColor = UIColor.greenColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p2Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p2Cell.transform = CGAffineTransformIdentity
                        }
                })
                if(turn){
                    turn = false
                }
                p2winOperations()
            }
        }else{
            if(Float(p1values![indexPath.row]) < Float(p2Values![indexPath.row])){
                p1Cell.backgroundColor = UIColor.greenColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p1Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p1Cell.transform = CGAffineTransformIdentity
                        }
                })
                p2Cell.backgroundColor = UIColor.redColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p2Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p2Cell.transform = CGAffineTransformIdentity
                        }
                })
                if(!turn){
                    turn = true
                }
                p1winOperations()
            }else{
                p1Cell.backgroundColor = UIColor.redColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p1Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p1Cell.transform = CGAffineTransformIdentity
                        }
                })
                p2Cell.backgroundColor = UIColor.greenColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        p2Cell.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            p2Cell.transform = CGAffineTransformIdentity
                        }
                })
                if(turn){
                    turn = false
                }
                p2winOperations()
            }
        }
        NSTimer.scheduledTimerWithTimeInterval(showAlertTime, target: self, selector: Selector("dismissAlert"), userInfo: nil, repeats: false)
    }
    
    @IBAction func backButton(sender: AnyObject) {
        Data().deleteObjectsFromEntity("Game")
        Data().saveGame(cardsetID, difficulty: difficulty, currentLap: currentLap, maxLaps: maxLaps, maxTime: maxTime, p1Name: p1Name, p1CardsArray: p1CardsArray, p2Name: p2Name, p2CardsArray: p2CardsArray, currentTime: currentTime, turn: turn)
    }
    
    func appMovedToBackground() {
        print("App to the Background. Saving Game.")
        Data().deleteObjectsFromEntity("Game")
        Data().saveGame(cardsetID, difficulty: difficulty, currentLap: currentLap, maxLaps: maxLaps, maxTime: maxTime, p1Name: p1Name, p1CardsArray: p1CardsArray, p2Name: p2Name, p2CardsArray: p2CardsArray, currentTime: currentTime, turn: turn)
    }
    
    
    // functions

    
    func showCard(){
        p1CardImage.image = Data().stringToImage(p1CardsArray[0].valueForKey("image") as! String!)
        p1CardInfo.text = p1CardsArray[0].valueForKey("info") as! String!
        p1NameLabel.text = p1CardsArray[0].valueForKey("name") as! String!
        p1CardImage.layer.cornerRadius = 10
        p1CardInfo.layer.cornerRadius = 10
        
        p2CardImage.image = Data().stringToImage(p2CardsArray[0].valueForKey("image") as! String!)
        p2CardInfo.text = p2CardsArray[0].valueForKey("info") as! String!
        p2NameLabel.text = p2CardsArray[0].valueForKey("name") as! String!
        p2CardImage.layer.cornerRadius = 10
        p2CardInfo.layer.cornerRadius = 10
        if(turn){
            p2CardImage.hidden = true
            //p2CardInfo.hidden = true
            p2CollectionView.hidden = true
            p2NameLabel.hidden = true
            p2InfoButton.hidden = true
            p2Back.hidden = false
            p1Back.hidden = true
        }else{
            p1CardImage.hidden = true
            //p1CardInfo.hidden = true
            p1CollectionView.hidden = true
            p1NameLabel.hidden = true
            p1InfoButton.hidden = true
            p1Back.hidden = false
            p2Back.hidden = true
        }
        
    }
    
    func drawOperations(){
        print("drawOperation")
        
        if(p1CardsArray.count > 1){
            drawStack.append(p1CardsArray[0])
            p1CardsArray.removeAtIndex(0)
        }
        if(p2CardsArray.count > 1){
            drawStack.append(p2CardsArray[0])
            p2CardsArray.removeAtIndex(0)
        }
        if(p2CardsArray.count == 1 && p1CardsArray.count == 1){
            self.performSegueWithIdentifier("gameOver", sender:self)
        }
    }
    
    func p1winOperations(){
        print("p1winOperation")
        
        //print(p1CardsArray)
        while(drawStack.count > 0){
            p1CardsArray.append(drawStack[0])
            drawStack.removeFirst()
        }
        p1CardsArray.append(p1CardsArray[0])
        p1CardsArray.append(p2CardsArray[0])
        p1CardsArray.removeAtIndex(0)
        p2CardsArray.removeAtIndex(0)
        //print(p1CardsArray)
        
        
    }
    func p2winOperations(){
        print("p2winOperation")
        while(drawStack.count > 0){
            p1CardsArray.append(drawStack[0])
            drawStack.removeFirst()
        }
        p2CardsArray.append(p1CardsArray[0])
        p2CardsArray.append(p2CardsArray[0])
        p2CardsArray.removeAtIndex(0)
        p1CardsArray.removeAtIndex(0)
        
    }
    
    func dismissAlert()
    {
        // Dismiss the alert from here
        currentLap++
        print("Anzahl P1 Karten " , p1CardsArray.count)
        print("Anzahl P2 Karten " , p2CardsArray.count)
        
        let bar = Float(p1CardsArray.count) / Float(p1CardsArray.count+p2CardsArray.count)
        progressView.setProgress(bar, animated: true)
        currentLap++
        //        progressView2.setProgress(bar, animated: true)
        //        progressView3.setProgress(bar, animated: true)
        //        progressView4.setProgress(bar, animated: true)
        //        progressView5.setProgress(bar, animated: true)
        
        if(p1CardsArray.count > 0 && p2CardsArray.count > 0 && currentLap < maxLaps){
            gameContinue()
        }
        else{
            self.performSegueWithIdentifier("gameOver", sender:self)
        }
        
    }
    
    func gameContinue(){
        
        if p1CardsArray.count > 0 && p2CardsArray.count > 0 {
            showCard()
            self.p2CollectionView.reloadData()
            self.p1CollectionView.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "gameOver"){
            
            let vc = segue.destinationViewController as! EndScreenViewController
            if (p1CardsArray.count > p2CardsArray.count){
                vc.labelTxt = "Spieler 1 hat gewonnen!"
                Data().saveRanking(p1Name, rounds: currentLap, time: currentTime)
            }else if(p1CardsArray.count == p2CardsArray.count){
                vc.labelTxt = "Unentschieden!"
            }else{
                vc.labelTxt = "Spieler 2 hat gewonnen!"
            }
            Data().deleteObjectsFromEntity("Game")
        }
    }
    
    
    
    
    // load data from core data
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
        p2Name = game[0].valueForKey("player2") as! String!
        p2Cards = game[0].valueForKey("player2Cards") as! String!
        currentTime = game[0].valueForKey("time") as! Double
        turn = game[0].valueForKey("turn") as! Bool!
        
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
