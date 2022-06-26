//
//  SharedInfo.swift
//  DiaBeta
//
//  Created by Vincentius Ian Widi Nugroho on 24/06/22.
//

import Foundation
import UIKit

class SharedInfo {
    
//    private var _id: String?
//    private var _username: String?
//    private var _points: Int
//    private var _accomplish: Int
//    private var _exceed: Int
//    private var _streak: Int
//
//    private var _category: [String]
//
    static let shared = SharedInfo()
//
//    private init() {
//
//        if let id = UserDefaults.standard.string(forKey: "userId") {
//            self._id = id
//        } else {
//            let generatedId = UUID().uuidString
//            UserDefaults.standard.set(generatedId, forKey: "userId")
//        }
//
//        self._username = UserDefaults.standard.string(forKey: "username")
//        self._points = UserDefaults.standard.integer(forKey: "userPoints")
//        self._accomplish = UserDefaults.standard.integer(forKey: "userAccom")
//        self._exceed = UserDefaults.standard.integer(forKey: "userExceed")
//        self._streak = UserDefaults.standard.integer(forKey: "userStreak")
//
////        self._category = UserDefaults.standard.stringArray(forKey: "category")!
//    }
    
    var category: [String] {
        get {
            if let savedCategory = UserDefaults.standard.stringArray(forKey: "category") {
                return savedCategory
            } else {
                return ["no data"]
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "category")
        }
    }
    
//    var id: String? {
//        get {
//            return self._id
//        }
//        set {
//            return
//        }
//    }
//
//    var username: String? {
//        get {
//            return self._username
//        }
//        set(newValue) {
//            self._username = newValue
//            UserDefaults.standard.set(newValue, forKey: "username")
//        }
//    }
//
//    var points: Int {
//        get {
//            return self._points
//        }
//        set(newValue) {
//            self._points = newValue
//            UserDefaults.standard.set(newValue, forKey: "userPoints")
//        }
//    }
//
//    var accomplish: Int {
//        get {
//            return self._accomplish
//        }
//        set(newValue) {
//            self._accomplish = newValue
//            UserDefaults.standard.set(newValue, forKey: "userAccom")
//        }
//    }
//    var exceed: Int {
//        get {
//            return self._exceed
//        }
//        set(newValue) {
//            self._exceed = newValue
//            UserDefaults.standard.set(newValue, forKey: "userExceed")
//        }
//    }
//    var streak: Int {
//        get {
//            return self._streak
//        }
//        set(newValue) {
//            self._streak = newValue
//            UserDefaults.standard.set(newValue, forKey: "userStreak")
//        }
//    }
//    var profileImageSet: Bool {
//        get {
//            return UserDefaults.standard.bool(forKey: "userPicSet")
//        }
//        set(newValue) {
//            UserDefaults.standard.set(newValue, forKey: "userPicSet")
//        }
//    }
//
//    var pic: NSData {
//        get {
//            if let userPicImg = UserDefaults.standard.object(forKey: "userPic") {
//                return userPicImg as! NSData
//            }
//            return UIImage(named: "PersonPlaceholder")!.jpegData(compressionQuality: 0.8)! as NSData
//        }
//        set(newValue) {
//            UserDefaults.standard.set(newValue, forKey: "userPic")
//        }
//    }
//
//
//    func addPoints(_ value: Int) {
//        self.points = self.points + value
//    }
//
//    func removePoints(_ value: Int) {
//        self.points = self.points - value
//    }
//
}
