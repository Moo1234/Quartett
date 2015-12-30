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

    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreTypeLabel: UILabel!
    var timeRanking = [NSManagedObject]()
    var rankingType = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swipe gestures to change rankings
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeGestures:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeGestures:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
//        tableView.addGestureRecognizer(leftSwipe)
//        tableView.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeRanking.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RankingTableViewCell", forIndexPath: indexPath) as! RankingTableViewCell
        let ranking = timeRanking[indexPath.row]
        if(rankingType){
            navigationBarTitle.title = "Runden Rangliste"
            scoreTypeLabel.text = "Runden"
            cell.nameLabel.text = ranking.valueForKey("player") as? String
            cell.scoreLabel.text =  String((ranking.valueForKey("scoreRounds") as? Int)!)
            cell.rankingLabel.text = String(indexPath.row + 1) + "."
        }else{
            navigationBarTitle.title = "Zeit Rangliste"
            scoreTypeLabel.text = "Zeit"
            cell.nameLabel.text = ranking.valueForKey("player") as? String
            cell.scoreLabel.text =  String((ranking.valueForKey("scoreTime") as? Double)!)
            cell.rankingLabel.text = String(indexPath.row + 1) + "."
        }
        return cell
    }
    @IBAction func resetRanking(sender: AnyObject) {
        let alert = UIAlertController(title: "Warnung", message: "Sind Sie sicher dass sie die Ranglisten zurücksetzen möchten? Dies kann nicht rückgängig gemacht werden.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertActionStyle.Cancel, handler: nil))
        let saveAction = UIAlertAction(title: "Zurücksetzen", style: UIAlertActionStyle.Destructive, handler: { (action:UIAlertAction) -> Void in
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            let coord = appDelegate.persistentStoreCoordinator
            
            let fetchRequest = NSFetchRequest(entityName: "Ranking")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try coord.executeRequest(deleteRequest, withContext: context)
            } catch let error as NSError {
                debugPrint(error)
            }
            self.loadData()
            self.tableView.reloadData()
        })
        alert.addAction(saveAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
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
        let fetchRequest = NSFetchRequest(entityName: "Ranking")
        
        if(rankingType){
            // sort less rounds as best
            let sortDescriptor = NSSortDescriptor(key: "scoreRounds", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }else{
            // sort less time as best
            let sortDescriptor = NSSortDescriptor(key: "scoreTime", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            timeRanking = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func swipeGestures(sender:UISwipeGestureRecognizer){
        if(sender.direction == .Left){
            tableLeft()
        }else{
            tableRight()
        }
    }
    @IBAction func tapLeft(sender: AnyObject) {
        tableLeft()
    }
    @IBAction func tapRight(sender: AnyObject) {
        tableRight()
    }
    
    func tableLeft(){
        leftButton.hidden=false
        rightButton.hidden=true
        rankingType = true
        loadData()
        self.tableView.reloadData()
    }
    func tableRight(){
        leftButton.hidden=true
        rightButton.hidden=false
        rankingType = false
        loadData()
        self.tableView.reloadData()
    }
    
    
}

