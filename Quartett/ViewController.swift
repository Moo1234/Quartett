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
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var continueGameButton: UIButton!
    
    var gameExists = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGame()
        
        rankingButton.layer.borderWidth = 2
        galleryButton.layer.borderWidth = 2
        newGameButton.layer.borderWidth = 2
        continueGameButton.layer.borderWidth = 2
        
        rankingButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        galleryButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        newGameButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        continueGameButton.layer.borderColor = UIColorFromRGB(0x209624).CGColor
        
        if(!gameExists){
            continueGameButton.hidden = true
        }else{
            continueGameButton.hidden = false
        }
        
        
    }

    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGame(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Game")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            let game =  results as! [NSManagedObject]
            if(game.count > 0){
                gameExists = true
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
}

