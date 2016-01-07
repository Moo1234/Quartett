//
//  EndScreenViewController.swift
//  Quartett
//
//  Created by Moritz Martin on 07.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit

class EndScreenViewController: UIViewController {

    @IBOutlet weak var winLabel: UILabel!
    
    var labelTxt: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.text = labelTxt

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
