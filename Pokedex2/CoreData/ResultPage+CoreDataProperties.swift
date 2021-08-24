//
//  ResultPage+CoreDataProperties.swift
//  
//
//  Created by Adi Mizrahi on 10/07/2021.
//
//

import Foundation
import CoreData


extension ResultPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultPage> {
        return NSFetchRequest<ResultPage>(entityName: "ResultPage")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}
