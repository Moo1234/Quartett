//
//  AppDelegate.swift
//  Quartett
//
//  Created by Moritz Martin on 19.11.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        //.
        // DB functions
        print("----------------- Reset Data -----------------")
        // delete all Data
        deleteObjectsFromEntity("Ranking")
        deleteObjectsFromEntity("Card")
        deleteObjectsFromEntity("Cardset")
        deleteObjectsFromEntity("Attribute")
        deleteObjectsFromEntity("Game")

        saveRanking("Hans", rounds: 15, time: 20.0)
        saveRanking("Peter", rounds: 10, time: 30.0)
        saveRanking("Willem", rounds: 5, time: 10.0)
        saveRanking("Jörg", rounds: 35, time: 100.0)

        saveCard(0, cardset: 0, name: "Robben", info: "Arjen Robben ist ein niederländischer Fußballspieler. Er steht seit dem 28. August 2009 beim Bundesligisten FC Bayern München unter Vertrag und gehört zum Kader der niederländischen A-Nationalmannschaft.", image: "rob", values: "92,92,86,32,82,64")
        saveCard(1, cardset: 0, name: "Ribery", info: "info1", image: "rib", values: "87,91,77,25,84,61")
        saveCard(2, cardset: 0, name: "Boateng", info: "info2", image: "boateng", values: "79,68,50,87,69,84")
        saveCard(3, cardset: 0, name: "Alaba", info: "info3", image: "alaba", values: "86,83,72,84,81,72")
        saveCard(4, cardset: 0, name: "Lewandowski", info: "info4", image: "lewa", values: "80,84,85,38,74,80")
        saveCard(5, cardset: 0, name: "Mueller", info: "info5", image: "mueller", values: "77,79,84,46,80,72")

        saveCardset(0, name: "Bayern", image: "CardSet0")
        
        
        saveCard(6, cardset: 1, name: "Reus", info: "info0", image: "reus", values: "90,88,60,42,97,31,71")
        saveCard(7, cardset: 1, name: "Hummels", info: "info1", image: "pic1", values: "11,12,13,14,15,16,31")
        saveCard(8, cardset: 1, name: "Schmelzer", info: "info2", image: "pic2", values: "1,2,3,4,5,6,21")
        saveCard(9, cardset: 1, name: "Aubameyang", info: "info3", image: "pic3", values: "70,90,70,90,70,90,1")
        saveCard(10, cardset: 1, name: "Kagawa", info: "info4", image: "pic4", values: "66,77,88,99,88,77,2")
        saveCard(11, cardset: 1, name: "buerki", info: "info5", image: "pic5", values: "66,77,88,99,88,77,5")
        
        saveCardset(1, name: "Dortmund",image: "CardSet1")

        
        saveAttribute(0, cardset: 0, name: "PAC", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(1, cardset: 0, name: "DRI", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(2, cardset: 0, name: "SHO", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(3, cardset: 0, name: "DEF", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(4, cardset: 0, name: "PAS", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(5, cardset: 0, name: "PHY", icon: "StandardIcon", unit: "m/s", condition: true)
        
        saveAttribute(6, cardset: 1, name: "PAC", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(7, cardset: 1, name: "DRI", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(8, cardset: 1, name: "SHO", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(9, cardset: 1, name: "DEF", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(10, cardset: 1, name: "PAS", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(11, cardset: 1, name: "PHY", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(2, cardset: 1, name: "bla", icon: "StandardIcon", unit: "km/h", condition: false)

        saveAttribute(6, cardset: 2, name: "PAC", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(7, cardset: 2, name: "DRI", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(8, cardset: 2, name: "SHO", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(9, cardset: 2, name: "DEF", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(10, cardset: 2, name: "PAS", icon: "StandardIcon", unit: "m/s", condition: true)
        saveAttribute(11, cardset: 2, name: "PHY", icon: "StandardIcon", unit: "m/s", condition: true)

        
        
        saveCardset(2, name: "Allstars", image: "CardSet3")
        
        
        saveCard(12, cardset: 2, name: "Messi", info: "info0", image: "messi", values: "92,86,88,95,24,62")
        saveCard(13, cardset: 2, name: "Ronaldo", info: "info1", image: "ronaldo", values: "92,80,93,90,33,78")
        saveCard(14, cardset: 2, name: "Suarez", info: "info2", image: "suarez", values: "82,79,88,88,42,79")
        saveCard(15, cardset: 2, name: "Robben", info: "info3", image: "rob", values: "92,82,86,92,32,64")
        saveCard(16, cardset: 2, name: "Hazard", info: "info0", image: "hazard", values: "90,84,82,92,32,64")
        saveCard(17, cardset: 2, name: "Ibrahimovic", info: "info1", image: "ibrahimovic", values: "73,81,90,85,31,86")
        saveCard(18, cardset: 2, name: "Neymar", info: "info2", image: "neymar", values: "90,72,80,92,30,58")
        saveCard(19, cardset: 2, name: "David Silva", info: "info3", image: "davidsilva", values: "73,89,74,89,32,58")
        saveCard(20, cardset: 2, name: "Thiago Silva", info: "info3", image: "thiagosilva", values: "74,73,57,73,90,79")
        saveCard(21, cardset: 2, name: "Iniesta", info: "info3", image: "iniesta", values: "75,87,72,90,59,63")
        saveCard(22, cardset: 2, name: "Rodriguez", info: "info3", image: "rodriguez", values: "78,84,86,85,40,72")
        saveCard(23, cardset: 2, name: "Lewandowski", info: "info3", image: "lewa", values: "80,74,85,84,38,80")
        saveCard(24, cardset: 2, name: "Boateng", info: "info3", image: "boateng", values: "79,68,50,87,69,84")
        saveCard(25, cardset: 2, name: "Kroos", info: "info3", image: "kroos", values: "56,88,81,82,66,69")
        saveCard(26, cardset: 2, name: "Modric", info: "info3", image: "modric", values: "76,84,74,89,71,68")
        saveCard(27, cardset: 2, name: "Özil", info: "info3", image: "ozil", values: "72,85,74,86,24,57")
        saveCard(28, cardset: 2, name: "Bale", info: "info3", image: "bale", values: "94,83,83,84,63,80")
        saveCard(29, cardset: 2, name: "Fabregas", info: "info3", image: "fabregas", values: "68,90,78,81,64,65")
        saveCard(30, cardset: 2, name: "ribery", info: "info3", image: "rib", values: "87,91,77,25,84,61")
        

        
        loadFromJsonFile("bikes/bikes")
        loadFromJsonFile("tuning/tuning")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Mo.Quartett" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Quartett", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            
            // manually deinstall App
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Save Methods ------------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    func saveRanking(player: String, rounds: Int, time: Double) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Ranking", inManagedObjectContext:managedContext)
        let newRanking = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        newRanking.setValue(player, forKey: "player")
        newRanking.setValue(rounds, forKey: "scoreRounds")
        newRanking.setValue(time, forKey: "scoreTime")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveCard(id: Int, cardset: Int, name: String, info: String, image: String, values: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Card", inManagedObjectContext:managedContext)
        let newCard = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        newCard.setValue(id, forKey: "id")
        newCard.setValue(cardset, forKey: "cardset")
        newCard.setValue(name, forKey: "name")
        newCard.setValue(info, forKey: "info")
        newCard.setValue(image, forKey: "image")
        newCard.setValue(values, forKey: "values")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveCardset(id: Int, name: String, image: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Cardset", inManagedObjectContext:managedContext)
        let newCardset = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        newCardset.setValue(id, forKey: "id")
        newCardset.setValue(name, forKey: "name")
        newCardset.setValue(image, forKey: "image")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveAttribute(id: Int, cardset: Int, name: String, icon: String, unit: String, condition: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Attribute", inManagedObjectContext:managedContext)
        let attribute = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        attribute.setValue(id, forKey: "id")
        attribute.setValue(cardset, forKey: "cardset")
        attribute.setValue(name, forKey: "name")
        attribute.setValue(icon, forKey: "icon")
        attribute.setValue(unit, forKey: "unit")
        attribute.setValue(condition, forKey: "condition")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Save Methods --------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Loading Methods ---------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    func loadFromJsonFile(filename: String){
        
        do{
            let targetURL = NSBundle.mainBundle().pathForResource(filename, ofType: "json")
            let data = try NSData(contentsOfFile: targetURL!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary

            let cardsetName = jsonResult.objectForKey("name") as! String
            let cards = jsonResult.objectForKey("cards") as! NSArray
            let properties = jsonResult.objectForKey("properties") as! NSArray
            
            // Save Cardset
            var cardSetId = 0
            while cardSetExists(cardSetId){
                cardSetId++
            }
            let images = cards[0].valueForKey("images") as! NSArray
            let cardSetImage = filename.componentsSeparatedByString("/")[0] + "/" + (images.objectAtIndex(0).valueForKey("filename") as! String)
            saveCardset(cardSetId, name: cardsetName, image: cardSetImage)
            
            // Save Card
            for var card = 0; card < cards.count; card++ {
                var cardId = 0
                while cardExists(cardId){
                    cardId++
                }
                let cardName = cards[card].valueForKey("name") as! String
//                let info = cards[card].valueForKey("description") as! NSDictionary
//                let cardInfo = info[card]?.
                let images = cards[card].valueForKey("images") as! NSArray
                let cardImage = filename.componentsSeparatedByString("/")[0] + "/" + (images.objectAtIndex(0).valueForKey("filename") as! String)
                
                let properties = cards[card].valueForKey("values") as! NSArray
                var values = ""
                for var propertyCount = 0; propertyCount < properties.count; propertyCount++ {
                    values += properties[propertyCount].valueForKey("value") as! String
                    if(propertyCount < properties.count - 1){
                        values += ","
                    }
                }
                saveCard(cardId, cardset: cardSetId, name: cardName, info: "Keine Info", image: cardImage, values: values)
            }
            
            // Save Properties
            for var attribute = 0; attribute < properties.count; attribute++ {
                var attributeId = 0
                while attributeExists(attributeId){
                    attributeId++
                }
                let attributeName = properties[attribute].valueForKey("text") as! String
                let attributeUnit = properties[attribute].valueForKey("unit") as! String
                var attributeCondition = false
                if((properties[attribute].valueForKey("compare") as! NSString).doubleValue == 1){
                    attributeCondition = true
                }else{
                    attributeCondition = false
                }
//                let attributePrecision = properties[attribute].valueForKey("precision") as! String
//                print(attributePrecision)
                saveAttribute(attributeId, cardset: cardSetId, name: attributeName, icon: "StandardIcon", unit: attributeUnit, condition: attributeCondition)
            }
        
        }catch{
            print("Json Datei konnte nicht gefunden werden")
        }
        
    }
    
    func cardSetExists(id: Int) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0{
                return false
            }else{
                return true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return false
    }
    
    func cardExists(id: Int) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0{
                return false
            }else{
                return true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return false
    }
    
    func attributeExists(id: Int) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Attribute")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0{
                return false
            }else{
                return true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return false
    }
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Loading Methods -----------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Delete Method -----------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    func deleteObjectsFromEntity(entity: String) {
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
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Delete Method -------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------

}

