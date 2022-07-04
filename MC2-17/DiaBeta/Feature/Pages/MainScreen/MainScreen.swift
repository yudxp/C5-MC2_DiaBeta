//
//  MainScreen.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit

//prepare your data array
var goodFoodInfo:[FoodInfo] = []
var badFoodInfo:[FoodInfo] = []

class MainScreen: UIViewController, UNUserNotificationCenterDelegate {

  @IBOutlet weak var bottomView: UIView!
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var newsView: UIView!
  @IBOutlet weak var newsTopLabel: UILabel!
  @IBOutlet weak var newsBottomLabel: UILabel!
  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var foodCollectionView: UICollectionView!
  @IBOutlet weak var badFoodCollectionView: UICollectionView!
  @IBOutlet weak var allGoodFood: UIButton!
  @IBOutlet weak var allBadFood: UIButton!
  
  var selectedFoodInfo: FoodInfo?

  
  override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.backgroundColor = UIColor(named: "AccentColor")
        bottomView.layer.cornerRadius = 10
        newsView.layer.cornerRadius = 8
        newsView.layer.shadowOffset = CGSize(width: 5, height: 5)
        newsView.layer.shadowRadius = 5
        newsView.layer.shadowOpacity = 0.3
        let nibCell = UINib(nibName: "GlucoseFoodCell", bundle: nil)
        foodCollectionView.register(nibCell, forCellWithReuseIdentifier: "foodCell")
        badFoodCollectionView.register(nibCell, forCellWithReuseIdentifier: "foodCell")
        goodFoodInfo = DBHelper.shared.getGood()
        badFoodInfo = DBHelper.shared.getBad()
        updateReminder(data: getReminder())
    }
  

  override func viewWillAppear(_ animated: Bool) {
    updateReminder(data: getReminder())
    goodFoodInfo = DBHelper.shared.getGood()
    badFoodInfo = DBHelper.shared.getBad()
    foodCollectionView.reloadData()
    badFoodCollectionView.reloadData()
    
  }
  
  @IBAction func seeAllGoodFood(_ sender: UIButton) {
    performSegue(withIdentifier: "toSeeAll", sender: self)
    print("All Good Food")
  }
  
  @IBAction func seeAllBadFood(_ sender: UIButton) {
    performSegue(withIdentifier: "toSeeAll", sender: self)
    print("All Bad Food")
  }
  
}

    //collection view function
extension MainScreen: UICollectionViewDelegate, UICollectionViewDataSource{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == foodCollectionView {
      return goodFoodInfo.count
    }
    else {
      return badFoodInfo.count
    }
  }


  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == foodCollectionView {
      selectedFoodInfo = goodFoodInfo[indexPath.row]
    }
    else {
      selectedFoodInfo = badFoodInfo[indexPath.row]
    }
    performSegue(withIdentifier: "foodDetail", sender: self)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! GlucoseFoodCell
    
    if collectionView == foodCollectionView {
      cell.foodImage.image = UIImage(data: (goodFoodInfo[indexPath.row].food?.photo)! as Data)
      cell.foodName.text = goodFoodInfo[indexPath.row].food?.name
      let stringArr = goodFoodInfo[indexPath.row].food?.category!
      let categoryArr = stringArr!.joined(separator: ",")
      cell.foodLabel.text = categoryArr
      cell.glucoseLabel.text = "+ " + String(goodFoodInfo[indexPath.row].selisih) + " mg/dL"
      cell.glucoseLabel.backgroundColor = UIColor.green
      return cell
    }
    else {
      cell.foodImage.image = UIImage(data: (badFoodInfo[indexPath.row].food?.photo)!as Data)
      cell.foodName.text = badFoodInfo[indexPath.row].food?.name
      let stringArr = badFoodInfo[indexPath.row].food?.category!
      let categoryArr = stringArr!.joined(separator: ",")
      cell.foodLabel.text = categoryArr
      cell.glucoseLabel.text = "+ " + String(badFoodInfo[indexPath.row].selisih) + " mg/dL"
      cell.glucoseLabel.backgroundColor = UIColor.red
      return cell
    }

  }
  
  //prepare send data when click
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "foodDetail" {
      let foodDetailVC = segue.destination as! UINavigationController
      let detailTarget = foodDetailVC.topViewController as? FoodDetailViewController
      detailTarget!.foodDetail = selectedFoodInfo
    }
  }
}

//MARK: - Logic reminder

extension MainScreen {
  func updateReminder(data:String) {
    switch data {
    case "noData":
      print("please share your food")
      newsImage.image = UIImage(systemName: "info.circle.fill")
      newsImage.tintColor = UIColor.orange
      newsTopLabel.text = "What's inside your tummy?"
      newsTopLabel.textColor = UIColor.black
      newsBottomLabel.text = "You can share it here"
      newsBottomLabel.textColor = UIColor.black
    case "updateData":
      print("update your glucose")
      newsImage.image = UIImage(systemName: "info.circle.fill")
      newsImage.tintColor = UIColor.red
      newsTopLabel.text = "Oh no, meals are not updated!"
      newsTopLabel.textColor = UIColor.red
      newsBottomLabel.text = "Please update your meal"
      newsBottomLabel.textColor = UIColor.red
    case "keepGoing":
      print("great keep update")
      newsImage.image = UIImage(systemName: "exclamationmark.circle.fill")
      newsImage.tintColor = UIColor(named: "AccentColor")
      newsTopLabel.text = "Nice Work!"
      newsTopLabel.textColor = UIColor.black
      newsBottomLabel.text = "You keep your meals updated"
      newsBottomLabel.textColor = UIColor.black
    default:
      print("no data")
    }
  }

  func getReminder()->String{
    let lastFoodInfo:[Food] = DBHelper.shared.getAllFood()
    if lastFoodInfo.isEmpty && lastFoodInfo.isEmpty {
      return "noData"
    }
    
    else if lastFoodInfo[lastFoodInfo.count - 1 ].postGula == 0 {
      return "updateData"
    }
    
    else {
      return "keepGoing"
      }
  }
}
