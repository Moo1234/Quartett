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
    var ranking = [NSManagedObject]()
    var rankingType = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swipe gestures to change rankings
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeGestures:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeGestures:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        
        // remove empty table part
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranking.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RankingTableViewCell", forIndexPath: indexPath) as! RankingTableViewCell
        let rank = ranking[indexPath.row]
        if(rankingType){
            navigationBarTitle.title = "Runden Rangliste"
            scoreTypeLabel.text = "Runden"
            cell.nameLabel.text = rank.valueForKey("player") as? String
            cell.scoreLabel.text =  String((rank.valueForKey("scoreRounds") as? Int)!)
            cell.rankingLabel.text = String(indexPath.row + 1) + "."
        }else{
            navigationBarTitle.title = "Zeit Rangliste"
            scoreTypeLabel.text = "Zeit"
            cell.nameLabel.text = rank.valueForKey("player") as? String
            cell.scoreLabel.text =  String((rank.valueForKey("scoreTime") as? Double)!)
            cell.rankingLabel.text = String(indexPath.row + 1) + "."
        }
        return cell
    }
    @IBAction func resetRanking(sender: AnyObject) {
        let alert = UIAlertController(title: "Warnung", message: "Sind Sie sicher dass sie die Ranglisten zurücksetzen möchten? Dies kann nicht rückgängig gemacht werden.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertActionStyle.Cancel, handler: nil))
        let saveAction = UIAlertAction(title: "Zurücksetzen", style: UIAlertActionStyle.Destructive, handler: { (action:UIAlertAction) -> Void in
            
            Data().resetRankings()
            self.ranking = Data().loadRankings(self.rankingType)
            self.tableView.reloadData()
        })
        alert.addAction(saveAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ranking = Data().loadRankings(rankingType)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        navigationBarTitle.title = "Runden Rangliste"
        ranking = Data().loadRankings(rankingType)
        self.tableView.reloadData()
    }
    func tableRight(){
        leftButton.hidden=true
        rightButton.hidden=false
        rankingType = false
        navigationBarTitle.title = "Zeit Rangliste"
        ranking = Data().loadRankings(rankingType)
        self.tableView.reloadData()
    }
    
    
}

