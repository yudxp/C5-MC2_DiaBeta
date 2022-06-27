//
//  DBHelper.swift
//  DiaBeta
//
//  Created by Vincentius Ian Widi Nugroho on 11/06/22.
//

import Foundation
import CoreData
import UIKit

class DBHelper {
    
    static let shared = DBHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var gulaList: [GulaDarah] = []
    private var foodList: [Food] = []
    private var foodInfoList: [FoodInfo] = []
    
    private init(){}
    
    // get semua data gula
    func getAllGula() -> [GulaDarah]{
        do{
            gulaList = try context.fetch(GulaDarah.fetchRequest())
        } catch {
            print("error")
        }
        return gulaList
    }
    
    // get semua data gula tapi sorted
    func getAllSortedGula() -> [GulaDarah]{
        do{
            let request = GulaDarah.fetchRequest() as NSFetchRequest<GulaDarah>
            
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            
            gulaList = try context.fetch(request)
        } catch {
            print("error")
        }
        return gulaList
    }
    
    // get data gula untuk tanggal spesifik, parameter: Date
    func getDateGula(_ pickedDate: Date) -> [GulaDarah] {
        do{
            let request = GulaDarah.fetchRequest() as NSFetchRequest<GulaDarah>
            
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            
            // Get today's beginning & end
            let dateFrom = calendar.startOfDay(for: pickedDate)
            let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)

            // Set predicate as date being today's date
            let fromPredicate = NSPredicate(format: "timestamp >= %@", dateFrom as NSDate)
            let toPredicate = NSPredicate(format: "timestamp < %@", dateTo! as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request.predicate = datePredicate
            
            // sort
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            
            gulaList = try context.fetch(request)
            
        } catch {
            print("error")
        }
        return gulaList
    }
    
    // get data gula untuk 7 hari, parameter: Date hari ini
    func getWeekGula(_ pickedDate: Date) -> [GulaDarah] {
        do{
            let request = GulaDarah.fetchRequest() as NSFetchRequest<GulaDarah>
            
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            
            // Get today's beginning & end
            let dateSelected = calendar.startOfDay(for: pickedDate)
            let dateTo = calendar.date(byAdding: .day, value: 1, to: dateSelected)
            let dateFrom = calendar.date(byAdding: .day, value: -7, to: dateTo!)

            // Set predicate as date being today's date
            let fromPredicate = NSPredicate(format: "timestamp >= %@", dateFrom! as NSDate)
            let toPredicate = NSPredicate(format: "timestamp < %@", dateTo! as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request.predicate = datePredicate
            
            // sort
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            
            gulaList = try context.fetch(request)
            
        } catch {
            print("error")
        }
        return gulaList
    }
    
    // get data gula untuk 30 hari, parameter: Date hari ini
    func getMonthGula(_ pickedDate: Date) -> [GulaDarah] {
        do{
            let request = GulaDarah.fetchRequest() as NSFetchRequest<GulaDarah>
            
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            
            // Get today's beginning & end
            let dateSelected = calendar.startOfDay(for: pickedDate)
            let dateTo = calendar.date(byAdding: .day, value: 1, to: dateSelected)
            let dateFrom = calendar.date(byAdding: .day, value: -30, to: dateTo!)

            // Set predicate as date being today's date
            let fromPredicate = NSPredicate(format: "timestamp >= %@", dateFrom! as NSDate)
            let toPredicate = NSPredicate(format: "timestamp < %@", dateTo! as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request.predicate = datePredicate
            
            // sort
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            
            gulaList = try context.fetch(request)
            
        } catch {
            print("error")
        }
        return gulaList
    }
    
    // menambah data input gula darah ke db
    func createGula(timestamp: Date, event: String, jumlah: Int64){
        let guldar = GulaDarah(context: context)
        guldar.event = event
        guldar.jumlah = jumlah
        guldar.timestamp = timestamp
        do {
            try context.save()
            if (event == "post"){
                calculate(timestamp: timestamp)
            }
        } catch {
            print("error")
        }
    }
    
    // function foodInfo
    // menghitung dan menentukan apakah masuk foodinfo atau tidak
    func calculate(timestamp: Date){
        foodList = getDateFood(timestamp)
        var i: Int = 0
        var notFound: Bool = true
        let currFood: Food = foodList[(foodList.count)-1]
        let selisih: Int64 = currFood.postGula - currFood.preGula
        if (selisih>30){
            let badList: [FoodInfo] = getBad()
            if(badList.count < 5){
                print("append bad")
                createInfo(food: currFood, type: "bad", selisih: selisih)
            } else {
                while(notFound && i < 5){
                    print("loop ke:")
                    print(i)
                    if (selisih >= badList[i].selisih){
                        notFound = !notFound
                        deleteInfo(info: badList[i])
                        createInfo(food: currFood, type: "bad", selisih: selisih)
                    }
                    i+=1
                }
            }
        } else {
            let goodList: [FoodInfo] = getGood()
            if(goodList.count < 5){
                print("append good")
                createInfo(food: currFood, type: "good", selisih: selisih)
            } else {
                while(notFound && i < 5){
                    if (selisih >= goodList[i].selisih){
                        notFound = !notFound
                        deleteInfo(info: goodList[i])
                        createInfo(food: currFood, type: "good", selisih: selisih)
                    }
                    i+=1
                }
            }
        }
    }
    
    func createInfo(food: Food, type: String, selisih: Int64){
        let foodInfo = FoodInfo(context: context)
        foodInfo.food = food
        foodInfo.type = type
        foodInfo.selisih = selisih
        do {
            try context.save()
        } catch {
            print("error create info")
        }
    }
    
    func getAllInfo() -> [FoodInfo]{
        do{
            foodInfoList = try context.fetch(FoodInfo.fetchRequest())
        } catch {
            print("error get all info")
        }
        return foodInfoList
    }
    
    func getGood() -> [FoodInfo]{
        do{
            let request = FoodInfo.fetchRequest() as NSFetchRequest<FoodInfo>

            // Set predicate as date being today's date
            let predicate = NSPredicate(format: "type == %@", "good")
            request.predicate = predicate
            
            foodInfoList = try context.fetch(request)
            
        } catch {
            print("error")
        }
        return foodInfoList
    }
    
    func getBad() -> [FoodInfo]{
        do{
            let request = FoodInfo.fetchRequest() as NSFetchRequest<FoodInfo>

            // Set predicate as date being today's date
            let predicate = NSPredicate(format: "type == %@", "bad")
            request.predicate = predicate
            
            foodInfoList = try context.fetch(request)
            
        } catch {
            print("error get bad")
        }
        return foodInfoList
    }
    
    func deleteInfo(info: FoodInfo){
        self.context.delete(info)
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
    func dailyUpdate(){
        // untuk testing
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        let weekDateTime = formatter.date(from: "2016/10/08 14:30")! as Date
        
        let now = Date()
        foodInfoList = getAllInfo()
        for i in 0..<foodInfoList.count{
            let currTimestamp: Date = (foodInfoList[i].food?.timestamp)!
//            let diff = Calendar.current.dateComponents([.day], from: currTimestamp, to: weekDateTime)
            let diff = Calendar.current.dateComponents([.day], from: currTimestamp, to: now)
            let diffDay = diff.day
            print("perbedaan hari:")
            print(diffDay)
            if(diffDay! >= 7){
                deleteInfo(info: foodInfoList[i])
            }
        }
    }
    
    // function to get food
    // get semua data makanan
    func getAllFood() -> [Food]{
        do{
            foodList = try context.fetch(Food.fetchRequest())
        } catch {
            print("error")
        }
        return foodList
    }
    
    // get semua data food tapi sorted
    func getAllSortedFood() -> [Food]{
        do{
            let request = Food.fetchRequest() as NSFetchRequest<Food>
            
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            
            foodList = try context.fetch(request)
        } catch {
            print("error")
        }
        return foodList
    }
    
    // get data makanan tanggal tertentu, parameter: Date
    func getDateFood(_ pickedDate: Date) -> [Food] {
        do{
            let request = Food.fetchRequest() as NSFetchRequest<Food>
            
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            // Get today's beginning & end
            let dateFrom = calendar.startOfDay(for: pickedDate) // eg. 2016-10-10 00:00:00
            let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)

            // Set predicate as date being today's date
            let fromPredicate = NSPredicate(format: "timestamp >= %@", dateFrom as NSDate)
            let toPredicate = NSPredicate(format: "timestamp < %@", dateTo! as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request.predicate = datePredicate
            
            // sort
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            
            foodList = try context.fetch(request)
            
        } catch {
            print("error")
        }
        return foodList
    }
    
    func getTimeFood(_ pickedDate: Date) -> Food {
        do{
            let request = Food.fetchRequest() as NSFetchRequest<Food>

            // Set predicate as date being today's date
            let predicate = NSPredicate(format: "timestamp == %@", pickedDate as NSDate)
            request.predicate = predicate
            
            foodList = try context.fetch(request)
            
        } catch {
            print("error")
        }
        return foodList[0]
    }
    
    // menambah data makanan baru ke db
    func createFood(timestamp: Date, nama: String, category: [String],image: NSData, preGula: Int64){
        let food = Food(context: context)
        food.category = category
        food.name = nama
        food.photo = image
        food.timestamp = timestamp
        food.preGula = preGula
        food.postGula = 0
        
        // cek jadi posttime/ngga
        gulaList = getWeekGula(timestamp)
        if(gulaList.count > 0){
            let startDate = gulaList[gulaList.count-1].timestamp!
            let diff = Calendar.current.dateComponents([.hour], from: startDate, to: timestamp)
            let diffHour = diff.hour
            print("perbedaan jam:")
            print(diffHour ?? -1)
            if(diffHour!<=2 && diffHour!>=0 && gulaList[gulaList.count-1].event == "pre"){
                createGula(timestamp: timestamp, event: "post", jumlah: preGula)
            }
        }
        createGula(timestamp: timestamp, event: "pre", jumlah: preGula)
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
    // editFood untuk hlmn update post gula, timestamp diisi gula pre makan
    func editFood(postGula: Int64, timestamp: Date){
        let editedFood: Food = getTimeFood(timestamp)
        //for testing
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        let someDateTime = formatter.date(from: "2016/10/01 14:30")! as Date
        
        editedFood.postGula = postGula
        do {
            try context.save()
            if (postGula>0){
                print("edit food")
                let currentDateTime = Date()
                createGula(timestamp: currentDateTime, event: "post", jumlah: postGula)
//                createGula(timestamp: someDateTime, event: "post", jumlah: postGula)
                print("added gula darah")
            }
        } catch {
            print("error")
        }
    }

}
