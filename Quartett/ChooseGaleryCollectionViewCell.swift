//
//  ChooseGaleryCollectionViewCell.swift
//  Quartett
//
//  Created by Moritz Martin on 21.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class ChooseGaleryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var galeryImage: UIImageView!
    @IBOutlet weak var galeryTitle: UILabel!

    @IBOutlet weak var checkButton: UIButton!
    
    var launchbool = true
    
    @IBAction func checkButtonPressed(sender: AnyObject) {
        if launchbool == true{
            launchbool = false
            checkButton.setImage(UIImage(named: "checkedButton"), forState: .Normal)
        }else{
            launchbool = true
            checkButton.setImage(UIImage(named: "uncheckedButton"), forState: .Normal)
        }
        
    }
}
