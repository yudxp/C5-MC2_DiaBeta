//
//  FoodViewController.swift
//  DiaBeta
//
//  Created by Nikita Felicia on 24/06/22.
//

import UIKit

class FoodViewController: UIViewController {
    
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var preGlucoseLbl: UILabel!
    @IBOutlet weak var postGlucoseLbl: UILabel!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var botFoodDetView: UIView!
    @IBOutlet weak var topFoodDetView: UIView!
  
    var foodDetail: Food?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImgView.layer.cornerRadius = 8
        categoryLbl.sizeToFit()
        botFoodDetView.layer.cornerRadius = 8
        detailImgView.image = UIImage(data: (foodDetail?.photo)!as Data)
        foodNameLbl.text = foodDetail?.name
        let categoryArray = foodDetail?.category
      let stringFromArray = categoryArray?.joined(separator: ",")
        categoryLbl.text = stringFromArray
        let date = foodDetail?.timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
      dateTimeLbl.text = dateFormatter.string(from: date ?? Date())
        preGlucoseLbl.text = "\(Int(foodDetail?.preGula ?? 0))"
        postGlucoseLbl.text = "\(Int(foodDetail?.postGula ?? 0))"
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    if segue.identifier == "toEditMeals" {
      let EditMealsVC = segue.destination as! UINavigationController
      let targetCont = EditMealsVC.topViewController as? EditMealsViewController
      targetCont!.foodDetailSegue = foodDetail
    }
  }
}
