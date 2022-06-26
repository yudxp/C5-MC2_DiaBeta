//
//  GlucoseFoodCell.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit

class GlucoseFoodCell: UICollectionViewCell {

  @IBOutlet weak var foodImage: UIImageView!
  @IBOutlet weak var glucoseLabel: UILabel!
  @IBOutlet weak var foodName: UILabel!
  @IBOutlet weak var foodLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layerSetup()
    }

}

extension GlucoseFoodCell {
  func layerSetup(){
    foodImage.layer.cornerRadius = 8
    foodImage.clipsToBounds = true
    glucoseLabel.layer.cornerRadius = 8
    glucoseLabel.layer.masksToBounds = true
    self.layer.cornerRadius = 8
    self.layer.masksToBounds = true
  }
}
