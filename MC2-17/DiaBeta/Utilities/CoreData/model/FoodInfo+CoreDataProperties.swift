//
//  FoodInfo+CoreDataProperties.swift
//  DiaBeta
//
//  Created by Vincentius Ian Widi Nugroho on 18/06/22.
//
//

import Foundation
import CoreData


extension FoodInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodInfo> {
        return NSFetchRequest<FoodInfo>(entityName: "FoodInfo")
    }

    @NSManaged public var selisih: Int64
    @NSManaged public var type: String?
    @NSManaged public var food: Food?

}

extension FoodInfo : Identifiable {

}
