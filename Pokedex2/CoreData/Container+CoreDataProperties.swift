//
//  Container+CoreDataProperties.swift
//  
//
//  Created by Adi Mizrahi on 10/07/2021.
//
//

import Foundation
import CoreData


extension Container {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Container> {
        return NSFetchRequest<Container>(entityName: "Container")
    }

    @NSManaged public var count: Int32
    @NSManaged public var next: String?
    @NSManaged public var previous: String?
    @NSManaged public var results: NSSet

}

// MARK: Generated accessors for results
extension Container {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: ResultPage)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: ResultPage)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}
