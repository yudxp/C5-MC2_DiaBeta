//
//  NotificationPreMealViewController.swift
//  DiaBeta
//
//  Created by Muhammad Abdul Fattah on 27/06/22.
//

import UserNotifications
import UIKit
import CoreData

class NotifPreMealViewController: UIViewController, UNUserNotificationCenterDelegate {

    var currentDateTime = Date()
    private var gulaList: [GulaDarah] = []
    private var foodList: [Food] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2016/10/01 10:31")! as Date
        let chosenDateTime = formatter.date(from: "2016/10/08 02:31")! as Date
        
        registerLocal()
        
        gulaList = DBHelper.shared.getDateGula(currentDateTime)
        
        DBHelper.shared.createGula(timestamp: someDateTime, event: "pre meal", jumlah: 120)
        
        print(gulaList.count)
        
        if gulaList.count > 0 {
            print("There are objects")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(scheduleLocal))
        }else {
            print("There are no object")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(registerLocal))
        }
    }
    
    @objc func registerLocal() {
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                   print("Yay!")
                } else {
                    print("D'oh!")
                }
            }
            
        }
                                                           
    @objc func scheduleLocal() {
            registerCategories()
        
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            
            let content = UNMutableNotificationContent()
            content.title = "Food Reminder"
            content.body = "Have you eating healthy today? Check it out here!"
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (120*60), repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
    }
                                                        
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler:
                                @escaping() -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //buat user swipe pas unlock
                    print("Default identifier")
                
            case "show" :
                print("Show more information...")
                
            default:
                break
            }
        }
        
        completionHandler()
    }
}


