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
    var foodDetail: Food?
    @IBOutlet weak var botFoodDetView: UIView!
    @IBOutlet weak var topFoodDetView: UIView!
    
  var imageCoreData: NSData?
  var namaCoreData: String?
  var kategoriCoreData: [String] = []
  var timeStampCoreData: Date?
  var preGulaCoreData: Int64?
  var postGulaCoreData: Int64?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImgView.layer.cornerRadius = 8
        categoryLbl.sizeToFit()
        botFoodDetView.layer.cornerRadius = 8
      
      
//      navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Edit",
//                                                          style : .plain,
//                                                          target: self,
//                                                          action: #selector(self.EditButtonTapped(_:)))
//
        
        detailImgView.image = UIImage(data: (foodDetail?.photo)!as Data)
      let image = detailImgView.image
      imageCoreData = image?.jpegData(compressionQuality: 0.5) as? NSData
        
        foodNameLbl.text = foodDetail?.name
      namaCoreData = foodNameLbl.text
     
        let categoryArray = foodDetail?.category!
      kategoriCoreData = categoryArray!
        let stringFromArray = categoryArray!.joined(separator: ",")
        categoryLbl.text = stringFromArray
        
        let date = foodDetail?.timestamp
      timeStampCoreData = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateTimeLbl.text = dateFormatter.string(from: date!)
        
        preGlucoseLbl.text = "\(Int(foodDetail?.preGula ?? 0))"
      preGulaCoreData = Int64(preGlucoseLbl.text!)
        postGlucoseLbl.text = "\(Int(foodDetail?.postGula ?? 0))"
      postGulaCoreData = Int64(postGlucoseLbl.text!)
      
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    if segue.identifier == "toEditMeals" {
      
      let EditMealsViewController = segue.destination as! EditMealsViewController
      EditMealsViewController.imageCoreData = imageCoreData
      EditMealsViewController.namaCoreData = namaCoreData
      EditMealsViewController.kategoriCoreData = kategoriCoreData
      EditMealsViewController.timeStampCoreData = timeStampCoreData
      EditMealsViewController.preGulaCoreData = preGulaCoreData
      EditMealsViewController.postGulaCoreData = postGulaCoreData
      
      //foodDetailVC.foodDetail = selectedFood //sesuain sama cell
    }
//  @objc func EditButtonTapped(_ sender:UIBarButtonItem!) {
//  print("Button Tapped")
//  performSegue(withIdentifier: "toEditMeals", sender: self)
//  //If you want pass data while segue you can use prepare segue method
// }
//
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "toEditMeals" {
//      let EditMealsViewController = segue.destination as! EditMealsViewController
//      //foodDetailVC.foodDetail = selectedFood //sesuain sama cell
//    }
    
  }
}
