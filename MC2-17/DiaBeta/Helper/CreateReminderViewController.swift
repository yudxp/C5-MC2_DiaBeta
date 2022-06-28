//
//  NotifViewController.swift
//  DiaBeta
//
//  Created by Nikita Felicia on 13/06/22.
//

import UserNotifications
import UIKit
import CoreData

class CreateReminderViewController: UIViewController, UNUserNotificationCenterDelegate {

    var currentDateTime = Date()
    private var gulaList: [GulaDarah] = []
    private var foodList: [Food] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "siomay.jpeg")
//        let imageData:NSData = image!.jpegData(compressionQuality: 0.5)! as NSData

        registerLocal()

        foodList = DBHelper.shared.getDateFood(currentDateTime)

//        DBHelper.shared.createFood(timestamp: currentDateTime, nama: "Udang Goreng", category: ["Karbo"], image: imageData, preGula: 120)
//        print(foodList.count)

//        if foodList.count > 0 {
//            print("There are objects")
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(registerLocal))
//        }else {
//            print("There are no object")
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(scheduleLocal))
//        }
    }

    func registerLocal() {
            let center = UNUserNotificationCenter.current()

            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                   print("Yay!")
                } else {
                    print("D'oh!")
                }
            }

        }

    func scheduleLocal() {
            registerCategories()

            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()

            let content = UNMutableNotificationContent()
            content.title = "Post-Glucose"
            content.body = "Please input your post-meal glucose"
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = .default

        //ini buat set kapan notifnya muncul -> ini muncul tiap jam 10 malam
//            var dateComponents = DateComponents()
//            dateComponents.calendar = Calendar.current
//            dateComponents.hour = 22
//            dateComponents.minute = 00
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

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

            print("Custom data received: \(customData)") //MASUKIN DATE TIME NYA DISINI

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

