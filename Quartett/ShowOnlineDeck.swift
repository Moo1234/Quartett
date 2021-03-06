//
//  ShowOnlineDeck.swift
//  Quartett
//
//  Created by Sebastian Haußmann on 19.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration

class ShowOnlineDeck: UIViewController{
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var downloadActionIndicator: UIActivityIndicatorView!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var noConView: UIView!
    @IBOutlet weak var noConLabel: UILabel!
    @IBOutlet weak var noConRetry: UIButton!
    @IBOutlet weak var noConBack: UIButton!
    
    
    @IBAction func retryPressed(sender: AnyObject) {
        viewDidLoad()
    }
    @IBAction func backPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("noConBack2", sender:self)
    }
    
    
    @IBAction func downloadButtonPressed(sender: AnyObject) {
        
        self.cardSetSize = self.names.count
        let alert = UIAlertController(title: "Download", message: "Wollen Sie das Kartenset herunterladen?", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.Default, handler: { action in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.saveSetInDB()
                self.showButton.hidden = false
                self.downloadButton.hidden = true
                
                
            })
            self.downloadView.hidden = false
            
            
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
    
    var cardSetIdForSegue = -1
    
    var images = [String]()
    var names = [String]()
    var ids = [Int]()
    var values = [String]()
    var attName = [String]()
    var attUnit = [String]()
    var condition = [Bool]()
    var cardSetSize: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let connection: Bool = isConnectedToNetwork()
        
        downloadActionIndicator.startAnimating()
        
        if(connection){
            noConView.hidden = true
            self.navBar.topItem?.title = deckName
            downloadView.layer.cornerRadius = 10
            
            
            link = "http://quartett.af-mba.dbis.info/decks/" + String(deckID) + "/cards/"
            loadCardsFromOnlineStore(link)
            if checkDeckExists() {
                downloadButton.hidden = true
                showButton.hidden = false
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                
            })
            
        }else{
            noConView.hidden = false
        }
        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    
    
    func checkDeckExists() -> Bool {
        let cardSetArray = Data().loadCardSets()
        for var index = 0; index < cardSetArray.count; index++ {
            if(cardSetArray[index].valueForKey("name") as! String == deckName){
                cardSetIdForSegue = cardSetArray[index].valueForKey("id") as! Int
                return true
            }
        }
        return false
    }
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath) as! OnlineCardsTableViewCell
        
        
        cell.cardName.text = names[indexPath.row]
        if(images.count > indexPath.row){
            let url = NSURL(string: images[indexPath.row])
            let data = NSData(contentsOfURL: url!)
            cell.cardImage.image = UIImage(data: data!)
            
        }
        
        return cell
    }
    
    
    
    func loadCardsFromOnlineStore(link: String){
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
                self.ids.append((post[index].valueForKey("id") as? Int)!)
                let id: Int = (post[index].valueForKey("id") as? Int!)!
                self.loadCardsImagesFromOnlineStore(link+String(id)+"/images/")
                
            }
            
        })
        task.resume()
        
    }

    func loadCardsImagesFromOnlineStore(link: String){
        let semaphore = dispatch_semaphore_create(0);
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
            dispatch_semaphore_signal(semaphore);
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidden = true
                
            })
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
    }
    
    
    
    
    
    func loadCardsAttributesFromOnlineStore(link: String){
        values.removeAll()
        attName.removeAll()
        attUnit.removeAll()
        condition.removeAll()
        
        let semaphore = dispatch_semaphore_create(0);
        
       
    
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
            dispatch_semaphore_signal(semaphore);
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    
    
    
    
    func saveSetInDB(){
        
        var cardSetId = 0
        var cardId = 0
        var attId = 0
        
        
        
        while Data().cardSetExists(cardSetId){
            cardSetId++
        }
        
        cardSetIdForSegue = cardSetId
        // delete directory if exists
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let dataPath = documentsURL.URLByAppendingPathComponent(String(cardSetId))
        do{
            try NSFileManager.defaultManager().removeItemAtURL(dataPath)
            print("Image folder already exists. Delete folder.")
        } catch  {
            print("No image folder found")
        }
        // create image folder
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(dataPath.path!, withIntermediateDirectories: false, attributes: nil)
            print("Create image folder at path: " + dataPath.path!)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        deckImage = saveImageToDevice(deckImage, id: cardSetId, name: "SetImage")
        Data().saveCardset(cardSetId, name: deckName, image: deckImage)
        
        let attLink = "http://quartett.af-mba.dbis.info/decks/" + String(deckID) + "/cards/"+String(7)+"/attributes/"
        
        
        loadCardsAttributesFromOnlineStore(attLink)
        //sleep(2)
        
        
        
        for var index = 0; index < names.count; ++index{
            while Data().cardExists(cardId){
                cardId++
            }
            let attLink = "http://quartett.af-mba.dbis.info/decks/" + String(deckID) + "/cards/"+String(ids[index])+"/attributes/"
            
            
            loadCardsAttributesFromOnlineStore(attLink)
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
            let url = saveImageToDevice(images[index], id: cardSetId, name: String(cardId))
            Data().saveCard(cardId, cardset: cardSetId, name: names[index], info: "Keine info!", image: url, values: valueString)
            //values.removeAll()
            
            
            
        }

        
        
        
        for var index3 = 0; index3 < attName.count; ++index3{
            while Data().attributeExists(attId){
                attId++
            }
            
            Data().saveAttribute(attId, cardset: cardSetId, name: attName[index3], icon: "", unit: attUnit[index3], condition: condition[index3])
        }
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("dismissView"), userInfo: nil, repeats: false)
        
    }
    
    func dismissView(){
        downloadView.hidden = true
    }
    
    
    func saveImageToDevice(imageURL: String, id: Int, name: String) -> String{
        
        let url = NSURL(string: imageURL)
        let data = NSData(contentsOfURL: url!)
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        if let image = UIImage(data: data!) {
            let path = String(id) + "/" + name + ".png"
            let fileURL = documentsURL.URLByAppendingPathComponent(path)
            if let pngImageData = UIImagePNGRepresentation(image) {
                pngImageData.writeToURL(fileURL, atomically: false)
                return path
            }
        }
        return "failed"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowCardSet" {
            let showCardSetViewController = segue.destinationViewController as! ShowCardSet
            
            showCardSetViewController.cardSetID = cardSetIdForSegue
            showCardSetViewController.cardSetImageString = deckImage
        }
        if segue.identifier == "noConBack2"{
            let vc = segue.destinationViewController as! ShowGallery
        }
    }
    
    
}
