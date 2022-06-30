//
//  SampleViewController.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit

class SampleViewController: UIViewController {

  @IBOutlet weak var dailyLabel: UILabel!
  @IBOutlet weak var weeklyLabel: UILabel!
  @IBOutlet weak var monthlyLabel: UILabel!
  @IBOutlet weak var higheshContainer: UIView!
  @IBOutlet weak var lowestContainer: UIView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        dailyLabel.layer.cornerRadius = 20
        dailyLabel.clipsToBounds = true
        weeklyLabel.layer.cornerRadius = 20
        weeklyLabel.clipsToBounds = true
        monthlyLabel.layer.cornerRadius = 20
        monthlyLabel.clipsToBounds = true
        higheshContainer.layer.cornerRadius = 12
        lowestContainer.layer.cornerRadius = 12
    }

}
