//
//  CategoryViewController.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 26/06/22.
//

import UIKit

class CategoryViewController: UIViewController {
    var foodCategory = ["Dairy", "Fruit", "Grains", "Protein", "Starch", "Sweets", "Vegetables"]
//    var categoryDict = ["Dairy": false, "Fruit": false, "Grains": false, "Protein" : false, "Starch" : false, "Sweets" : false, "Vegetables" : false]
//    var categoryIndex = ["Dairy": 1, "Fruit": 2, "Grains": 3, "Protein" : 4, "Starch" : 5, "Sweets" : 6, "Vegetables" : 7]
  @IBOutlet weak var categoryTable: UITableView!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return foodCategory.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = foodCategory[indexPath.row]
    if indexPath.row == 0 {
      cell.layer.cornerRadius = 10
      cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    else if indexPath.row == foodCategory.count-1 {
      cell.layer.cornerRadius = 10
      cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
  }
  
}
