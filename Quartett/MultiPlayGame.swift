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
    
    
    @IBOutlet weak var p1CardImage: UIImageView!
    @IBOutlet weak var p1CardInfo: UITextView!
    @IBOutlet weak var p1CollectionView: UICollectionView!
    @IBOutlet weak var p1NameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
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
        
        p2CardImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2CardInfo.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2CollectionView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2NameLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        
        loadGame()
        
        loadCardset()
        loadAttribute()
        let p1CardsString = stringToArrayString(p1Cards)
        let p2CardsString = stringToArrayString(p2Cards)
        p1CardsArray = loadCards(p1CardsString)
        p2CardsArray = loadCards(p2CardsString)
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
        p1CardInfo.hidden = false
        p2CardInfo.hidden = false
        
        if(Float(p1values![indexPath.row]) == Float(p2Values![indexPath.row])){
            let cell = p1CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell1
            cell.backgroundColor = UIColor.orangeColor()
            let cell2 = p2CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell2
            cell2.backgroundColor = UIColor.orangeColor()
            drawOperations()
            
        }else if(condition){
            //            print("P1: \(values![indexPath.row]) P2: \(cpuValues![indexPath.row])")
            if(Float(p1values![indexPath.row]) > Float(p2Values![indexPath.row])){
                let cell = p1CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell1
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
                let cell2 = p2CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell2
                cell2.backgroundColor = UIColor.redColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        cell2.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            cell2.transform = CGAffineTransformIdentity
                        }
                })
                if(!turn){
                    turn = true
                }
                p1winOperations()
            }else{
                let cell = p1CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell1
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
                let cell2 = p2CollectionView.cellForItemAtIndexPath(indexPath) as! MultiplayerAttributeCollectionViewCell2
                cell2.backgroundColor = UIColor.greenColor()
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        cell2.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        UIView.animateWithDuration(0.6){
                            cell2.transform = CGAffineTransformIdentity
                        }
                })
                if(turn){
                    turn = false
                }
                p2winOperations()
            }
        }else{
            if(Float(p1values![indexPath.row]) < Float(p2Values![indexPath.row])){
                
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
                if(!turn){
                    turn = true
                }
                p1winOperations()
            }else{
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
                if(turn){
                    turn = false
                }
                p2winOperations()
            }
        }
        NSTimer.scheduledTimerWithTimeInterval(showAlertTime, target: self, selector: Selector("dismissAlert"), userInfo: nil, repeats: false)
    }
    

    
    // functions
    //Convert String to Array(String)
    func stringToArrayString(x:String) -> [String]{
        let toArray = x.componentsSeparatedByString(",")
        
        return toArray
    }
    
    func showCard(){
        
        p1CardImage.image = UIImage(named: p1CardsArray[0].valueForKey("image") as! String!)
        p1CardInfo.text = p1CardsArray[0].valueForKey("info") as! String!
        p1NameLabel.text = p1CardsArray[0].valueForKey("name") as! String!
        p1CardImage.layer.cornerRadius = 10
        p1CardInfo.layer.cornerRadius = 10
        
        p2CardImage.image = UIImage(named: p2CardsArray[0].valueForKey("image") as! String!)
        p2CardInfo.text = p2CardsArray[0].valueForKey("info") as! String!
        p2NameLabel.text = p2CardsArray[0].valueForKey("name") as! String!
        p2CardImage.layer.cornerRadius = 10
        p2CardInfo.layer.cornerRadius = 10
        if(turn){
            p2CardImage.hidden = true
            p2CardInfo.hidden = true
            p2CollectionView.hidden = true
            p2NameLabel.hidden = true
        }else{
            p1CardImage.hidden = true
            p1CardInfo.hidden = true
            p1CollectionView.hidden = true
            p1NameLabel.hidden = true
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
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
