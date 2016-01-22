//
//  ChooseGalery.swift
//  Quartett
//
//  Created by Moritz Martin on 21.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class ChooseGalery: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardsetArray = [NSManagedObject]()
    
    var p1NameTemp: String = ""
    var p2NameTemp: String = ""
    var difficultyTemp: Int = 0
    var roundsTemp: Int = 0
    var timeTemp: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData(){
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
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.cardsetArray.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ChooseGaleryCollectionViewCell
        let cardset = cardsetArray[indexPath.row]
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        cell.showButton.layer.borderWidth = 2
        cell.showButton.layer.borderColor = UIColor.blackColor().CGColor
        
        cell.chooseButton.layer.borderWidth = 2
        cell.chooseButton.layer.borderColor = UIColor.blackColor().CGColor
        cell.chooseButton.tag = indexPath.row
        cell.showButton.tag = indexPath.row
        
        cell.galeryImage?.image = Data().stringToImage((cardset.valueForKey("image") as? String)!)
        cell.galeryTitle?.text = cardset.valueForKey("name") as? String

        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("chooseButtonPressed", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "chooseButtonPressed"){
            let vc = segue.destinationViewController as! GameSettingsViewController
            
            if(sender!.tag != nil){
                vc.setID = sender!.tag
                vc.cardSetIconString = (self.cardsetArray[sender!.tag].valueForKey("image") as? String)!
            }else{
                let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
                let indexPath = indexPaths[0] as NSIndexPath
                vc.setID = (self.cardsetArray[indexPath.row].valueForKey("id") as? Int)!
                vc.cardSetIconString = (self.cardsetArray[indexPath.row].valueForKey("image") as? String)!
                
                vc.playerOneNameVar = p1NameTemp
                vc.cpuDifficulty = difficultyTemp
                vc.gameTime = timeTemp
                vc.numberLaps = roundsTemp
                vc.playerTwoNameVar = p2NameTemp
                vc.backID = 1
            }
            
            
        }else if (segue.identifier == "showCardSetButton"){
            let vc2 = segue.destinationViewController as! ShowCardSet
            
            
            if(sender!.tag != nil){
                
                vc2.cardSetID = (self.cardsetArray[sender!.tag].valueForKey("id") as? Int)!
                vc2.navigationBarTitle = (self.cardsetArray[sender!.tag].valueForKey("name") as? String)!
                vc2.cardSetImageString = (self.cardsetArray[sender!.tag].valueForKey("image") as? String)!
                vc2.idInt = 1
                vc2.p1NameTemp1 = p1NameTemp
                vc2.p2NameTemp1 = p2NameTemp
                vc2.difficultyTemp1 = difficultyTemp
                vc2.roundsTemp1 = roundsTemp
                vc2.timeTemp1 = timeTemp
                
            }else{
                let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
                let indexPath = indexPaths[0] as NSIndexPath
            
                vc2.cardSetID = (self.cardsetArray[indexPath.row].valueForKey("id") as? Int)!
                vc2.navigationBarTitle = (self.cardsetArray[indexPath.row].valueForKey("name") as? String)!
                vc2.cardSetImageString = (self.cardsetArray[indexPath.row].valueForKey("image") as? String)!
                
                vc2.p1NameTemp1 = p1NameTemp
                vc2.p2NameTemp1 = p2NameTemp
                vc2.difficultyTemp1 = difficultyTemp
                vc2.roundsTemp1 = roundsTemp
                vc2.timeTemp1 = timeTemp
            }
            
        }else if (segue.identifier == "backButton"){
            
            
            let vc = segue.destinationViewController as! GameSettingsViewController
            vc.playerOneNameVar = p1NameTemp
            vc.cpuDifficulty = difficultyTemp
            vc.gameTime = timeTemp
            vc.numberLaps = roundsTemp
            vc.playerTwoNameVar = p2NameTemp
            vc.backID = 1
        }
    
    
    }
    
    //****************************
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
