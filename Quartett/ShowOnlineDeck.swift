//
//  ShowOnlineDeck.swift
//  Quartett
//
//  Created by Sebastian Haußmann on 19.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit


class ShowOnlineDeck: UIViewController{
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    @IBAction func downloadButtonPressed(sender: AnyObject) {
        
        
        let alert = UIAlertController(title: "UIAlertController", message: "Wollen Sie das Kartenset herunterladen?", preferredStyle: UIAlertControllerStyle.Alert)
    
       
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.Default, handler: { action in
            self.saveSetInDB()
        }))
        alert.addAction(UIAlertAction(title: "Nein", style: UIAlertActionStyle.Cancel, handler: { action in
        
        }))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    var deckID = -1
    var deckName = ""
    var link: String = ""
    var deckImage = ""
    
    

    var images = [String]()
    var names = [String]()
    var ids = [Int]()
    var values = [String]()
    var attName = [String]()
    var attUnit = [String]()
    var condition = [Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.topItem?.title = deckName
    
        
        link = "http://quartett.af-mba.dbis.info/decks/" + String(deckID) + "/cards/"
        loadCardsFromOnlineStore(link)

        sleep(2)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath) as! OnlineCardsTableViewCell
        
        
        cell.cardName.text = names[indexPath.row]
        let url = NSURL(string: images[indexPath.row])
        let data = NSData(contentsOfURL: url!)
        cell.cardImage.image = UIImage(data: data!)
        return cell
    }
    
    
    
    func loadCardsFromOnlineStore(link: String){
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
                self.ids.append((post[index].valueForKey("id") as? Int)!)
                var id: Int = (post[index].valueForKey("id") as? Int!)!
                self.loadCardsImagesFromOnlineStore(link+String(id)+"/images/")
            }
        })
        task.resume()
        
    }

    
    func loadCardsImagesFromOnlineStore(link: String){
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
                self.images.append((post[index].valueForKey("image") as? String)!)
            }
        })
        task.resume()
    }
    
    
    
    
    
    func loadCardsAttributesFromOnlineStore(link: String){
        attName.removeAll()
        attUnit.removeAll()
        condition.removeAll()
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
                self.values.append((post[index].valueForKey("value") as? String)!)
                self.attUnit.append((post[index].valueForKey("unit") as? String)!)
                self.attName.append((post[index].valueForKey("name") as? String)!)
                if (post[index].valueForKey("what_wins") as? String)! == "higher_wins"{
                    self.condition.append(true)
                }else{
                    self.condition.append(false)
                }
            }
        })
        task.resume()
    }

    
    func saveSetInDB(){
        
        var cardSetId = 0
        var cardId = 0
        var attId = 0
        
        
        while AppDelegate().cardSetExists(cardSetId){
            cardSetId++
        }
        
        //DeckImage passt noch nicht!
        AppDelegate().saveCardset(cardSetId, name: deckName, image: deckImage)
        
        var attLink = "http://quartett.af-mba.dbis.info/decks/" + String(deckID) + "/cards/"+String(7)+"/attributes/"
        
        loadCardsAttributesFromOnlineStore(attLink)
        sleep(2)
        print(values)
        
        for var index = 0; index < names.count; ++index{
            while AppDelegate().cardExists(cardId){
                cardId++
            }
            var attLink = "http://quartett.af-mba.dbis.info/decks/" + String(deckID) + "/cards/"+String(ids[index])+"/attributes/"
            
            loadCardsAttributesFromOnlineStore(attLink)
            sleep(2)
            print(values)
            
            
            var valueString = ""
            for var index2 = 0; index2 < values.count; ++index2{
                if index2 == values.count-1{
                    valueString += String(values[index2])
                }else{
                    valueString += String(values[index2])+","
                }
            }
            
            print(valueString)
            let url = NSURL(string: images[index])
            let data = NSData(contentsOfURL: url!)
            AppDelegate().saveCard(cardId, cardset: cardSetId, name: names[index], info: "Keine info!", image: String(data), values: valueString)
            values.removeAll()
            
        }
        
        print(attName.count)
        for var index3 = 0; index3 < attName.count; ++index3{
            while AppDelegate().attributeExists(attId){
                attId++
            }
            
            AppDelegate().saveAttribute(attId, cardset: cardSetId, name: attName[index3], icon: "", unit: attUnit[index3], condition: condition[index3])
        }
        
        
        
    }
  
    
}
