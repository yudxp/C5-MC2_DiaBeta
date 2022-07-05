//
//  DBTest.swift
//  DiaBeta
//
//  Created by Vincentius Ian Widi Nugroho on 11/06/22.
//

import UIKit
import Foundation
import CoreData

class DBTest: UIViewController {
    
    var currentDateTime = Date()
//    var listofDate: [Date] = []
    private var gulaList: [GulaDarah] = []
    private var foodList: [Food] = []
    private var foodInfoList: [FoodInfo] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tesButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("started core data test")

        // set date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        let someDateTime = formatter.date(from: "2022/07/03 13:47")! as Date
//        let someDateTime2 = formatter.date(from: "2022/07/04 09:30")! as Date
//        let chosenDateTime = formatter.date(from: "2016/10/08 02:31")! as Date
//
//        // set image to NSData
//        let image = UIImage(named: "siomay.jpeg")
//        let imageData:NSData = image!.jpegData(compressionQuality: 0.5)! as NSData
//
//        print(currentDateTime)
//        print(someDateTime)
//        print(type(of: someDateTime))
//        print(type(of: currentDateTime))
//        listofDate.append(currentDateTime)
//        listofDate.append(someDateTime!)
//        print(getDate("yow"))
//
//        gulaList = DBHelper.shared.getAllGula()
//        print(gulaList[0].timestamp)
//
        // contoh command core data gula darah
//        DBHelper.shared.createGula(timestamp: someDateTime, event: "pre", jumlah: 120)
//        DBHelper.shared.createGula(timestamp: someDateTime2, event: "pre", jumlah: 140)
//        gulaList = DBHelper.shared.getAllGula()
//        gulaList = DBHelper.shared.getAllSortedGula()
//        gulaList = DBHelper.shared.getDateGula(chosenDateTime)
//        print(gulaList.count)
//        for i in 0..<gulaList.count{
//            print(gulaList[i].timestamp)
//        }
//
//        // contoh command core data food
//        DBHelper.shared.createFood(timestamp: someDateTime, nama: "bad7", category: ["1"], image: imageData, preGula: 100)
//        DBHelper.shared.editFood(postGula: 140, timestamp: someDateTime)
//        foodList = DBHelper.shared.getAllFood()
//        foodList.append(DBHelper.shared.getTimeFood(someDateTime))
//        foodList = DBHelper.shared.getAllSortedFood()
//        foodList = DBHelper.shared.getDateFood(someDateTime)
//        print(foodList.count)
//        for i in 0..<foodList.count{
//            print(foodList[i].postGula)
//        }

//        gulaList = DBHelper.shared.getWeekGula(Date())
//        print(gulaList.count)
//        for i in 0..<gulaList.count{
//            print(gulaList[i].jumlah)
//        }
        
        print(DBHelper.shared.getLowest().jumlah)

//        DBHelper.shared.createInfo(food: foodList[0], type: "bad", selisih: 69)
//        DBHelper.shared.dailyUpdate()
//        foodInfoList = DBHelper.shared.getGood()
//        foodInfoList = DBHelper.shared.getBad()
//        foodInfoList = DBHelper.shared.getAllInfo()
//        print(foodInfoList.count)
//        for i in 0..<foodInfoList.count{
//            print(foodInfoList[i].selisih)
//        }
//
//        myImageView.image = UIImage(data: foodList[0].photo as! Data)

        print("end of test")
  }


}
