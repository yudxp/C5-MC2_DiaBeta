////
////  NotifHelper.swift
////  DiaBeta
////
////  Created by Yudha Hamdi Arzi on 28/06/22.
////
//
//import Foundation
//import UserNotifications
//import CoreData
//import UIKit
//private var foodDate: [Food] = []
//
//class NotifHelper: UIViewController, UNUserNotificationCenterDelegate {
//  
//  func registerLocal(){
//    let center = UNUserNotificationCenter.current()
//    
//    center.requestAuthorization(options: [.alert, .badge, .sound]) {
//      granted, error in if granted {
//        print ("Yay")
//      } else {
//        print ("Yahh")
//      }
//    }
//  }
//  
//  func sheduleLocal() {
//    registerCategories()
//    let center = UNUserNotificationCenter.current()
//    center.removeAllPendingNotificationRequests()
//    
//    let content = UNMutableNotificationContent()
//    content.title = "Post-Glucose"
//    content.body = "Please input your post-meal glucose"
//    content.categoryIdentifier = "Alarm"
//    content.userInfo = ["CustomData": "fizzbuzz"]
//    content.sound = .default
//    
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//    center.add(request)
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
//      let userInfo = response.notification.request.content.userInfo
//      
//      if let customData = userInfo["customData"] as? String {
//          
//          print("Custom data received: \(customData)") //MASUKIN DATE TIME NYA DISINI
//          
//          switch response.actionIdentifier {
//          case UNNotificationDefaultActionIdentifier:
//              //buat user swipe pas unlock
//                  print("Default identifier")
//              
//          case "show" :
//              print("Show more information...")
//              
//          default:
//              break
//          }
//      }
//      
//      completionHandler()
//  }
//  
//  
//}
