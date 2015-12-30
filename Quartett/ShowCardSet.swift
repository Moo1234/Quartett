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
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    
    var cardArray = [NSManagedObject]()
    var cardSetID = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
//        let fetchRequest2 = NSFetchRequest(entityName: "Cardset")
//        var cardArray2 = [NSManagedObject]()
//        do {
//            let results =
//            try managedContext.executeFetchRequest(fetchRequest2)
//            cardArray2 = results as! [NSManagedObject]
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//        let text = cardArray2[cardSetID].valueForKey("cards") as! String
//        let cardIDsArray: [Int] = stringToArrayString(text)
//        
//        print(cardIDsArray)
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
//        let predicate = NSPredicate(format: "id contains[c] %@", cardIDsArray)
//       // let predicate = NSPredicate(format: "title == %@", "Best Language")
//        
//        // Set the predicate on the fetch request
//        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cardArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func stringToArrayString(x:String) -> [Int]{
        let stringArray = x.componentsSeparatedByString(",")
        var intArray: [Int] = []
        for (var i=0; i < stringArray.count; i++){
            intArray.append(Int(stringArray[i]) ?? 0)
        }
        return intArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath) as! ShowCardSetCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        cell.nameLabel?.text = card.valueForKey("name") as? String
        cell.cardSetImage?.image = UIImage(named: (card.valueForKey("image") as? String)!)
        cell.informationLabel?.text = card.valueForKey("info") as? String
        
        return cell
    }


}
