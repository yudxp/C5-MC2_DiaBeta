//
//  CategoryViewerController.swift
//  DiaBeta
//
//  Created by Muhammad Abdul Fattah on 23/06/22.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController{
  
  @IBOutlet weak var saveSettingButton: UIButton!
  
  var category = ["Dairy", "Fruit", "Grains", "Protein", "Starch", "Sweets", "Vegetables"]
  var categoryDict = ["Dairy": false, "Fruit": false, "Grains": false, "Protein" : false, "Starch" : false, "Sweets" : false, "Vegetables" : false]
  var categoryIndex = ["Dairy": 1, "Fruit": 2, "Grains": 3, "Protein" : 4, "Starch" : 5, "Sweets" : 6, "Vegetables" : 7]
  
  var selectedCategoryString = [String]()
  var selectedCategoryIndex = [Int]()
  
  //MARK: - ViewDidLoad
  override func viewDidLoad()
  {
    super.viewDidLoad()
    saveSettingButton.layer.cornerRadius = 10
    self.tabBarController?.tabBar.isHidden = true
  }
  
  //MARK: - to Save
  @IBAction func saveSettingPressed(_ sender: Any)
  {
    getSelectedCategory()
    SharedInfo.shared.category = selectedCategoryString
    print(SharedInfo.shared.category)
    print(selectedCategoryString)
  }
  
  //MARK: - Function Helpers
  private func getSelectedCategory()
  {
    selectedCategoryString = categoryDict.allKeys(forValue: true)
    for string in selectedCategoryString {
      if categoryIndex[string] != nil {
        selectedCategoryIndex.append(categoryIndex[string]!)
      }
    }
  }
  
  //MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.isScrollEnabled = false
    }
  }
  
}

//MARK: - Table Delegate
extension CategoryViewController: UITableViewDelegate
{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if categoryDict[category[indexPath.row]] == true {
      categoryDict[category[indexPath.row]] = false
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
      
    } else {
      categoryDict[category[indexPath.row]] = true
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
  }
}

//MARK: - Table Data Source

extension CategoryViewController:UITableViewDataSource
{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

//  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    return "CATEGORY"
//  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    category.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = category[indexPath.row]
  return cell
  }

}



