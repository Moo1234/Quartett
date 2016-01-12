//
//  MultiPlayGame.swift
//  Quartett
//
//  Created by Moritz Martin on 12.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit

class MultiPlayGame: UIViewController {

    @IBOutlet weak var p2CardInfo: UITextView!
    @IBOutlet weak var p2CardImage: UIImageView!
    @IBOutlet weak var p2CollectionView: UICollectionView!
    
    
    @IBOutlet weak var p1CardImage: UIImageView!
    @IBOutlet weak var p1CardInfo: UITextView!
    @IBOutlet weak var p1CollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p2CardImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2CardInfo.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        p2CollectionView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
