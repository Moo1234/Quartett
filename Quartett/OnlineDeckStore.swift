//
//  OnlineDeckStore.swift
//  Quartett
//
//  Created by Sebastian Haußmann on 16.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved..
//

import UIKit
import CoreData
import SystemConfiguration

class OnlineDeckStore: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var noConLabel: UILabel!
    @IBOutlet weak var noConView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noConRetry: UIButton!
    @IBOutlet weak var noConBack: UIButton!
   
    @IBAction func retryPressed(sender: AnyObject) {
        noConView.hidden = true
        viewDidLoad()

    }
    
    
    @IBAction func backPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("noConBack", sender:self)
        
        
    }
    
    var descriptions = [String]()
    var images = [String]()
    var names = [String]()
    var ids = [Int]()
    
    var cardSetArray = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let connection: Bool = isConnectedToNetwork()
        
        if (connection){
            loadFromOnlineStore("http://quartett.af-mba.dbis.info/decks/")
            
            
            cardSetArray = Data().loadCardSets()
        }else{
            noConView.hidden = false
        
        }
        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
//                print(indexPath.row)
                showOnlineDeckViewController.deckID = ids[indexPath.row]
                showOnlineDeckViewController.deckName = names[indexPath.row]
                showOnlineDeckViewController.deckImage = images[indexPath.row]
                
            }
        }
        if segue.identifier == "noConBack"{
            let vc = segue.destinationViewController as! ShowGallery
        }
    }
}
