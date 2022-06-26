//
//  GulaDarah+CoreDataProperties.swift
//  DiaBeta
//
//  Created by Vincentius Ian Widi Nugroho on 18/06/22.
//
//

import Foundation
import CoreData


extension GulaDarah {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GulaDarah> {
        return NSFetchRequest<GulaDarah>(entityName: "GulaDarah")
    }

    @NSManaged public var event: String?
    @NSManaged public var jumlah: Int64
    @NSManaged public var timestamp: Date?

}

extension GulaDarah : Identifiable {

}
