//
//  CoreDataHelper.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 10/07/2021.
//

import Foundation
import CoreData
protocol CoreDataHelperProtocol {
    func create<T>(type: T.Type, managedObjectContext: NSManagedObjectContext, completion: @escaping ((T) -> Void))
    func fetch<T>(type: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, relationshipKeysToFetch: [String]?, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void))
    func fetch<T>(type: T.Type, predicate: NSPredicate?, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void))
    func fetch<T>(type: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void))
    func fetchCount<T>(type: T.Type, predicate: NSPredicate, managedObjectContext: NSManagedObjectContext, completion: @escaping ((Int) -> Void))
}


class CoreDataHelper {
    
    static var shared = CoreDataHelper()
    
    
    func fetch<T>(type: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, relationshipKeysToFetch: [String]?, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void)) {
        
        managedObjectContext.perform {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
            if let predicate = predicate {
                request.predicate = predicate
            }
            if let sortDescriptors = sortDescriptors {
                request.sortDescriptors = sortDescriptors
            }
            if let relationshipKeysToFetch = relationshipKeysToFetch {
                request.relationshipKeyPathsForPrefetching = relationshipKeysToFetch
            }
            do {
                let result = try managedObjectContext.fetch(request)
                completion(result as? [T])
            } catch {
                completion(nil)
            }
        }
    }
}
