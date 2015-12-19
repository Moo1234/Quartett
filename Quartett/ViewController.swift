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
    //aaaa
    var people = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //save("Hans", rounds: 15, time: 20.0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func save(player: String, rounds: Int, time: Double) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Ranking",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(player, forKey: "player")
        person.setValue(rounds, forKey: "scoreRounds")
        person.setValue(time, forKey: "scoreTime")
        
        //4
        do {
            try managedContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}

