//
//  ChooseGalery.swift
//  Quartett
//
//  Created by Moritz Martin on 21.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class ChooseGalery: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardsetArray = [NSManagedObject]()
    
    let imagestest = [UIImage(named: "rib"), UIImage(named: "rob"), UIImage(named: "rib")]
    

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
        
        cell.galeryImage?.image = UIImage(named: (cardset.valueForKey("image") as? String)!)
        cell.galeryTitle?.text = cardset.valueForKey("name") as? String
        
        return cell
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
