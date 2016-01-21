//
//  ShowCardSet.swift
//  Quartett
//
//  Created by Baschdi on 30.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class ShowCardSet: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var cardSetImage: UIImageView!
    @IBOutlet weak var back1: UIButton!
    @IBOutlet weak var back2: UIButton!
    
    var cardSet = [NSManagedObject]()
    var cardArray = [NSManagedObject]()
    var attributeArray = [NSManagedObject]()
    var cardSetID = 0
    var cardSetImageString = ""
    var navigationBarTitle = "Kartenset"
    var count = 0
    var cardID = 0
    var idInt = 0
    
    //GameSettingsVars
    var p1NameTemp1: String = ""
    var p2NameTemp1: String = ""
    var difficultyTemp1: Int = 0
    var roundsTemp1: Int = 0
    var timeTemp1: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if idInt == 0{
            back2.hidden = true
            back2.enabled = false
        }else{
            back1.hidden = true
            back1.enabled = false
        
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadCardArray()
        loadAttributes()
        
        if(cardSetImageString.containsString(".png")){
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
            let data = NSData(contentsOfFile: documentsURL.path! + "/" + cardSetImageString)
            self.cardSetImage.image = UIImage(data: data!)
        }else{
            self.cardSetImage.image = UIImage(named: cardSetImageString)
        }
        setLabel.text = self.navigationBarTitle
    }
    
    func loadCardArray(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "cardset == %d", cardSetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cardArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    func loadAttributes(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Attribute")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "cardset == %d", cardSetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            attributeArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionView){
            return self.cardArray.count
        }else{
            collectionView.setContentOffset(CGPointZero, animated: false)
            return self.attributeArray.count
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(collectionView == self.collectionView){
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath) as! ShowCardSetCollectionViewCell
            
            let card = cardArray[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.blackColor().CGColor
            cell.layer.cornerRadius = 10
            cell.nameLabel?.text = card.valueForKey("name") as? String
            let imageString = (card.valueForKey("image") as? String)!
            if(imageString.containsString(".png")){
                let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
                let data = NSData(contentsOfFile: documentsURL.path! + "/" + imageString)
                cell.cardSetImage?.image = UIImage(data: data!)
            }else{
                cell.cardSetImage?.image = UIImage(named: imageString)
            }
            cell.textview?.text = card.valueForKey("info") as? String
            cell.textview.selectable = false
            cell.textview.contentOffset = CGPoint(x: 0, y: 7)
            cardID = indexPath.row
            return cell
        }else{
            // Attribute sind komischerweise bis zum ersten rechts-links scrollen noch vertauscht
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AttributeCell", forIndexPath: indexPath) as! ShowAttributeCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.blackColor().CGColor
            let card = cardArray[cardID]
            let values = card.valueForKey("values")?.componentsSeparatedByString(",")
            //            print(values)
            cell.attributeValueLabel?.text = values![indexPath.row]
            let attribute = attributeArray[indexPath.row]
            if attribute.valueForKey("unit") as? String != ""{
                
                cell.attributeUnitLabel?.text = attribute.valueForKey("unit") as? String
            }else{
                cell.attributeUnitLabel?.text = "n.A."
            }
            if !(attribute.valueForKey("condition") as? Bool)! {
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.iconImage?.image = UIImage(named: "ButtonDown")
            }else{
                cell.backgroundColor = UIColor.whiteColor()
                cell.iconImage?.image = UIImage(named: "ButtonUp")
            }
            if((attribute.valueForKey("icon") as? String)! != ""){
                cell.iconImage?.image = UIImage(named: (attribute.valueForKey("icon") as? String)!)
            }
            cell.attributeNameLabel?.text = attribute.valueForKey("name") as? String
            
            
            if(count == (values?.count)!-1){
                count = 0
            }else{
                count++
            }
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if(collectionView == self.collectionView){
            return CGSizeMake(collectionView.bounds.size.width-20, collectionView.bounds.size.height-20)
        }else{
//            let cellsHeight = CGFloat(Int((cardArray[0].valueForKey("values")?.componentsSeparatedByString(",").count)!) / 2)
            return CGSizeMake(collectionView.bounds.size.width/2, collectionView.bounds.size.height/3)
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if(collectionView == self.collectionView){
            guard let showCardSetCollectionViewCell = cell as? ShowCardSetCollectionViewCell else { return }
            showCardSetCollectionViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "backToChoose"){
            let vc = segue.destinationViewController as! ChooseGalery
        
            vc.p1NameTemp = p1NameTemp1
            vc.p2NameTemp = p2NameTemp1
            vc.difficultyTemp = difficultyTemp1
            vc.roundsTemp = roundsTemp1
            vc.timeTemp = timeTemp1

        }
    }
    
    
}
