//
//  ViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 19.11.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var rankings = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // DB functions
        // deleteIncidents("Ranking") // delete all Rankings
        // save("Hans", rounds: 15, time: 20.0) // Save entry in Rankings
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func save(player: String, rounds: Int, time: Double) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Ranking", inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)

        person.setValue(player, forKey: "player")
        person.setValue(rounds, forKey: "scoreRounds")

        do {
            try managedContext.save()
            rankings.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
 
    func deleteIncidents(entity: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }

}

