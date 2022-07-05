//
//  SeeAllBadGoodViewController.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 28/06/22.
//

import UIKit

class SeeAllBadGoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var foodTable: UITableView!
    
    var foodInfos:[FoodInfo] = []
    var selectedFoodInfo: FoodInfo?
    let dateFormatter = DateFormatter()

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFoodInfo = foodInfos[indexPath.row]
        performSegue(withIdentifier: "foodDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        
        let selisih = foodInfos[indexPath.row].selisih
        let category = foodInfos[indexPath.row].food!.category?.joined(separator: ", ")
        let rowDate = dateFormatter.string(from: (foodInfos[indexPath.row].food!.timestamp! as Date))
        cell.myLabel.text = "+ \(selisih)"
        if (foodInfos[indexPath.row].food!.postGula == 0){
            cell.myLabel1.layer.opacity = 1
            cell.myLabel.layer.opacity = 0
        } else{
            cell.myLabel1.layer.opacity = 0
            cell.myLabel.layer.opacity = 1
        }
        if (selisih>=30){
            cell.myLabel.backgroundColor = UIColor.red
        } else {
            cell.myLabel.backgroundColor = UIColor.green
        }
        cell.myLabel2.text = foodInfos[indexPath.row].food!.name
        cell.myLabel3.text = category
        cell.myLabel4.text = rowDate
//        cell.myImageView.image = UIImage(data: foodInfos[indexPath.row].photo !as Data
        cell.myImageView.image = UIImage(data: (foodInfos[indexPath.row].food!.photo)!as Data)
      cell.myImageView.contentMode = .scaleAspectFill
      cell.myImageView.layer.masksToBounds = true
    
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        foodTable.register(nib, forCellReuseIdentifier: "MealTableViewCell")
        foodTable.delegate = self
        foodTable.dataSource = self
        
        dateFormatter.dateFormat = "HH:mm"
        foodInfos = DBHelper.shared.getGood()
        // Do any additional setup after loading the view.
    }

    //prepare send data when click
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "foodDetail" {
  //      let foodDetailVC = segue.destination as! FoodDetailViewController
  //      foodDetailVC.foodDetail = selectedFoodInfo
        let foodDetailVC = segue.destination as! UINavigationController
        let detailTarget = foodDetailVC.topViewController as? FoodDetailViewController
        detailTarget!.foodDetail = selectedFoodInfo
      }
    }

}
