//
//  MainScreen.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit
//import UserNotifications

var goodFoodInfo:[FoodInfo] = [] //collect good food data
var badFoodInfo:[FoodInfo] = [] //collect bad food data

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
//        registerLocal()
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
//    reminderLocal()
    
  }
  @IBAction func seeAllBadFood(_ sender: UIButton) {
    performSegue(withIdentifier: "toSeeAllBad", sender: self)
    print("All Bad Food")
//    reminderLocal()
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
//      let foodDetailVC = segue.destination as! FoodDetailViewController
//      foodDetailVC.foodDetail = selectedFoodInfo
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

//MARK: - Notification Center

//extension MainScreen {
//  func registerLocal() {
//          let center = UNUserNotificationCenter.current()
//
//          center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//              if granted {
//                 print("Yay!")
//              } else {
//                  print("D'oh!")
//              }
//          }
//
//      }
//  
//  func reminderLocal() {
//          registerCategories()
//
//          let center = UNUserNotificationCenter.current()
//          center.removeAllPendingNotificationRequests()
//
//          let content = UNMutableNotificationContent()
//          content.title = "Post-Glucose"
//          content.body = "Please input your post-meal glucose"
//          content.categoryIdentifier = "alarm"
//          content.userInfo = ["customData": "fizzbuzz"]
//          content.sound = .default
//
//          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//          let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//          center.add(request)
//  }
//  
//  func scheduleLocal() {
//          registerCategories()
//
//          let center = UNUserNotificationCenter.current()
//          center.removeAllPendingNotificationRequests()
//
//          let content = UNMutableNotificationContent()
//          content.title = "Post-Glucose"
//          content.body = "Please input your post-meal glucose"
//          content.categoryIdentifier = "alarm"
//          content.userInfo = ["customData": "fizzbuzz"]
//          content.sound = .default
//
//      //ini buat set kapan notifnya muncul -> ini muncul tiap jam 10 malam
//            var dateComponents = DateComponents()
//            dateComponents.calendar = Calendar.current
//            dateComponents.hour = 22
//            dateComponents.minute = 00
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//            center.add(request)
//  }
//  
//  func registerCategories() {
//      let center = UNUserNotificationCenter.current()
//      center.delegate = self
//
//      let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
//      let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
//
//      center.setNotificationCategories([category])
//  }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler:
//                              @escaping() -> Void) {
//    
//    let storyboard = UIStoryboard(name: "EditMeals", bundle: nil) //change to edit food with custom data
//    
//    //initiate the view controller from storyboard
//    let editFoodVC = storyboard.instantiateViewController(withIdentifier: "EditMealsViewController")
//
//    self.present(editFoodVC, animated: true)
//        
////      let userInfo = response.notification.request.content.userInfo
//      // Print message ID
//    
////      if let customData = userInfo["customData"] as? String {
////
////          print("Custom data received: \(customData)") //MASUKIN DATE TIME NYA DISINI
////
////          switch response.actionIdentifier {
////          case UNNotificationDefaultActionIdentifier:
////              //buat user swipe pas unlock
////                  print("Default identifier")
////
////          case "show" :
////              print("Show more information...")
////
////          default:
////              break
////          }
////      }
//
//      completionHandler()
//  }
//  
//}


