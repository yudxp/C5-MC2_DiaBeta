//
//  MealTableViewCell.swift
//  DiaBeta
//
//  Created by Nikita Felicia on 22/06/22.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myLabel1: UILabel!
    @IBOutlet var myLabel2: UILabel!
    @IBOutlet var myLabel3: UILabel!
    @IBOutlet var myLabel4: UILabel!
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myImageView2: UIImageView!
    @IBOutlet var myButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myImageView.layer.cornerRadius = 8
        myImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myImageView.contentMode = .scaleAspectFit
        
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 8
        myLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
