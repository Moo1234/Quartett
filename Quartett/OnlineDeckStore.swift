//
//  OnlineDeckStore.swift
//  Quartett
//
//  Created by Sebastian Haußmann on 16.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit

class OnlineDeckStore: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromOnlineStore()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    func loadFromOnlineStore(){
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://quartett.af-mba.dbis.info")
        let request = NSMutableURLRequest(URL: url!)
        //        request.setValue("Basic c3R1ZGVudDphZm1iYQ==", forHTTPHeaderField: "Authorization")
        
        request.setValue("application/json; Basic c3R1ZGVudDphZm1iYQ==", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        
        session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            print(String(data: data!, encoding: NSUTF8StringEncoding))
            // parse the result as JSON, since that's what the API provides
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("Server noch nicht online?")
                print("error trying to convert data to JSON")
                return
            }
            // now we have the post, let's just print it to prove we can access it
            print("The post is: " + post.description)
            
            // the post object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            if let postTitle = post["title"] as? String {
                print("The title is: " + postTitle)
            }
            
//            // Read the JSON
//            do {
//                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
//                    // Print what we got from the call
//                    print(ipString)
//                    
//                    // Parse the JSON to get the IP
//                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                    let origin = jsonDictionary["origin"] as! String
//                    
//                    // Update the label
//                    print(origin)
//                    //                    self.performSelectorOnMainThread("updateIPLabel:", withObject: origin, waitUntilDone: false)
//                }else{
//                    print("No String")
//                }
//            } catch {
//                print("bad things happened")
//            }
        }).resume()
    }
}
