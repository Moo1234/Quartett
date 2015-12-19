//
//  ViewController.swift
//  Quartett
//
//  Created by Baschdi on 17.12.15.
//  Copyright © 2015 Baschdi. All rights reserved.
//

import UIKit
import CoreData

class RankingController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var timeRanking = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Zeit Rangliste"
       // tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeRanking.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RankingTableViewCell", forIndexPath: indexPath) as! RankingTableViewCell
        let ranking = timeRanking[indexPath.row]
        cell.nameLabel.text = ranking.valueForKey("player") as? String
        cell.scoreLabel.text =  String((ranking.valueForKey("scoreRounds") as? Int)!)
        cell.rankingLabel.text = String(indexPath.row + 1) + "."
        
        
//        let path = person.valueForKey("image") as? String
//        var image : UIImage = UIImage(named: path!)!
//        cell!.imageView!.image = image
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Ranking")
        
        // sort less rounds as best
        let sortDescriptor = NSSortDescriptor(key: "scoreRounds", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            timeRanking = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

