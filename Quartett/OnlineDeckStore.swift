//
//  OnlineDeckStore.swift
//  Quartett
//
//  Created by Sebastian Haußmann on 16.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved..
//

import UIKit
import CoreData

class OnlineDeckStore: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var descriptions = [String]()
    var images = [String]()
    var names = [String]()
    var ids = [Int]()
    
    var cardSetArray = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromOnlineStore("http://quartett.af-mba.dbis.info/decks/")

        
        cardSetArray = ShowGallery().loadCardSet()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCell", forIndexPath: indexPath) as! DeckTableViewCell
        cell.deckNameLabel.text = names[indexPath.row]
        cell.deckDescriptionLabel.text = descriptions[indexPath.row]
        
        let url = NSURL(string: images[indexPath.row])
        let data = NSData(contentsOfURL: url!)
        cell.deckIcon.image = UIImage(data: data!)
        if(checkDeckExists(names[indexPath.row])){
            cell.deckExistsView.image = UIImage(named: "check")
        }
        return cell
    }
    
    
    func checkDeckExists(name: String) -> Bool {
        for var index = 0; index < cardSetArray.count; index++ {
            if(cardSetArray[index].valueForKey("name") as! String == name){
                return true
            }
        }
        return false
    }
    
    func loadFromOnlineStore(link: String){
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        guard let url = NSURL(string: link) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSMutableURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        urlRequest.HTTPMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Basic c3R1ZGVudDphZm1iYQ==", forHTTPHeaderField: "Authorization")
        
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            let post: NSArray
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: NSJSONReadingOptions.MutableContainers) as! NSArray
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the post, let's just print it to prove we can access it
//            print("The post is: " + post.description)
            
            // the post object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            
            for var index = 0; index < post.count; index++ {
                self.names.append((post[index].valueForKey("name") as? String)!)
                self.descriptions.append((post[index].valueForKey("description") as? String)!)
                self.images.append((post[index].valueForKey("image") as? String)!)
                self.ids.append((post[index].valueForKey("id") as? Int)!)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidden = true
            })
        })
        task.resume()
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDeck" {
            let showOnlineDeckViewController = segue.destinationViewController as! ShowOnlineDeck
            
            // Get the cell that generated this segue.
            if let selectedDeckCell = sender as? DeckTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedDeckCell)!
                print(indexPath.row)
                showOnlineDeckViewController.deckID = ids[indexPath.row]
                showOnlineDeckViewController.deckName = names[indexPath.row]
                showOnlineDeckViewController.deckImage = images[indexPath.row]
                
            }
        }
    }
}
