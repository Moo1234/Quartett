//
//  OnlineCardsTableViewCell.swift
//  Quartett
//
//  Created by Moritz Martin on 19.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit

class OnlineCardsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
