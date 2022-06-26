//
//  FoodDetailViewController.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var preGlucoseLbl: UILabel!
    @IBOutlet weak var postGlucoseLbl: UILabel!
    @IBOutlet weak var foodNameLbl: UILabel!
    var foodDetail: Food?
    @IBOutlet weak var botFoodDetView: UIView!
    @IBOutlet weak var topFoodDetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImgView.layer.cornerRadius = 8
        categoryLbl.sizeToFit()
        botFoodDetView.layer.cornerRadius = 8
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Edit",
                                                            style : .plain,
                                                            target: self,
                                                            action : nil)
        
        detailImgView.image = UIImage(data: (foodDetail?.photo)!as Data)
        
        foodNameLbl.text = foodDetail?.name
     
        let categoryArray = foodDetail?.category!
        let stringFromArray = categoryArray!.joined(separator: ",")
        categoryLbl.text = stringFromArray
        
        let date = foodDetail?.timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateTimeLbl.text = dateFormatter.string(from: date!)
        
        preGlucoseLbl.text = "\(Int(foodDetail?.preGula ?? 0))"
        postGlucoseLbl.text = "\(Int(foodDetail?.postGula ?? 0))"
    }
}
