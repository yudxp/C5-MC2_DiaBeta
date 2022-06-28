//
//  FoodDetailViewController.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit

class FoodDetailViewController: UIViewController {
    var foodDetail: FoodInfo?
  
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var preGlucoseLabel: UILabel!
    @IBOutlet weak var postGlucoseLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var botFoodDetailView: UIView!
    @IBOutlet weak var topFoodDetailView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("hehe")
        botFoodDetailView.layer.cornerRadius = 8
        categoryLabel.sizeToFit()
        detailImageView.layer.cornerRadius = 8

      
        let categoryArray = foodDetail?.food?.category!
        let stringFromArray = categoryArray!.joined(separator: ",")
        let date = foodDetail?.food?.timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        detailImageView.image = UIImage(data: (foodDetail?.food?.photo)!as Data)
        preGlucoseLabel.text = "\(Int(foodDetail?.food?.preGula ?? 0))"
        postGlucoseLabel.text = "\(Int(foodDetail?.food?.postGula ?? 0))"
        categoryLabel.text = stringFromArray
        dateTimeLabel.text = dateFormatter.string(from: date!)
        foodNameLabel.text = foodDetail?.food?.name
        let glucoseDifference = Int(foodDetail?.selisih ?? 0)
        if glucoseDifference < 30 {
          topFoodDetailView.backgroundColor = UIColor(named: "AccentColor")
        }
        else {
          topFoodDetailView.backgroundColor = UIColor.red
      }
      print("title")
    }
  
}
