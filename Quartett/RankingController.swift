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
    
    @IBOutlet weak var Label1: UITableView!
    @IBOutlet weak var label2: UITableView!
    @IBOutlet weak var label3: UITableView!
    @IBOutlet weak var tableView: UITableView!
    var timeRanking = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Bla")
        title = "Zeit Rangliste"
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeRanking.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let person = timeRanking[indexPath.row]
        print("Test" , person.valueForKey("player"))
        cell!.textLabel!.text = person.valueForKey("player") as? String
//        let path = person.valueForKey("image") as? String
//        var image : UIImage = UIImage(named: path!)!
//        cell!.imageView!.image = image
        
        return cell!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Ranking")
        
        //3
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

