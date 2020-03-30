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


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var numberOfSlices: Int16
    @NSManaged public var pizzaType: String?
    @NSManaged public var status: String?
    @NSManaged public var tableNumber: String?

}
