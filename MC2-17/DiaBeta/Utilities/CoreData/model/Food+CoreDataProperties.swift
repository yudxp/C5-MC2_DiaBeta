//
//  Food+CoreDataProperties.swift
//  DiaBeta
//
//  Created by Vincentius Ian Widi Nugroho on 18/06/22.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var category: [String]?
    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var postGula: Int64
    @NSManaged public var preGula: Int64
    @NSManaged public var timestamp: Date?
    @NSManaged public var foodInfo: FoodInfo?

}

extension Food : Identifiable {

}
