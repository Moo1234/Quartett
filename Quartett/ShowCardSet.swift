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
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    
    var cardArray = [NSManagedObject]()
    var cardSetID = 0
    var navigationBarTitle = "Kartenset"
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        navigationBarItem.title = self.navigationBarTitle
    }
    
    func loadData(){
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 0){
            return self.cardArray.count
        }else{
            let values = self.cardArray[0].valueForKey("values")?.componentsSeparatedByString(",")
            return values!.count
        }
    }
    var ids = [Int]()
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(collectionView == self.collectionView){
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath) as! ShowCardSetCollectionViewCell
            let card = cardArray[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.blackColor().CGColor
            
            cell.nameLabel?.text = card.valueForKey("name") as? String
            cell.cardSetImage?.image = UIImage(named: (card.valueForKey("image") as? String)!)
            cell.textview?.text = card.valueForKey("info") as? String
            ids.append(indexPath.row)
            
            return cell
        }else{
            // Attribute sind komischerweise bis zum ersten rechts-links scrollen noch vertauscht
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AttributeCell", forIndexPath: indexPath) as! ShowAttributeCollectionViewCell
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.blackColor().CGColor
            let card = cardArray[ids[0]]
            let values = card.valueForKey("values")?.componentsSeparatedByString(",")
//            print(values)
            cell.attributeLabel.text = values![indexPath.row]
            if(count == (values?.count)!-1){
                count = 0
                ids.removeFirst()
            }else{
                count++
            }
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if(collectionView == self.collectionView){
            guard let showCardSetCollectionViewCell = cell as? ShowCardSetCollectionViewCell else { return }
            showCardSetCollectionViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        }
    }
    
    
}
