//
//  Person+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Carlos Wilson on 24/10/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}

extension Person : Identifiable {

}
