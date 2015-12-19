//
//  RankingTableViewCell.swift
//  Quartett
//
//  Created by Baschdi on 19.12.15.
//  Copyright © 2015 Moritz Martin. All rights reserved.
//


import UIKit

class RankingTableViewCell: UITableViewCell {
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
