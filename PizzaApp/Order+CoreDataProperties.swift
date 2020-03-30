//
//  Order+CoreDataProperties.swift
//  PizzaApp
//
//  Created by Isc. Torres on 3/28/20.
//  Copyright © 2020 isctorres. All rights reserved.
//
//

import Foundation
import CoreData

// Protocolo Identifiable es para identificar univocamente cada item
extension Order: Identifiable{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: UUID
    @NSManaged public var numberOfSlices: Int16
    @NSManaged public var pizzaType: String
    @NSManaged public var status: String
    @NSManaged public var tableNumber: String

    var orderStatus: Status{
        set{ status = newValue.rawValue }
        get{ Status(rawValue: status) ?? .pending }
    }
}

enum Status : String{
    case pending = "Pending"
    case preparing = "Preparing"
    case completed = "Completed"
}
