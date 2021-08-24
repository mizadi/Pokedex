//
//  DatabaseHelper.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 10/07/2021.
//

import Foundation
import CoreData
class DatabaseHelper {
    
    static var sharedInstance = DatabaseHelper()
    
    var container: NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func getContainers() -> [Container]? {
        let request = NSFetchRequest<Container>(entityName: "Container")
        //let sort = NSSortDescriptor(key: "create_date", ascending: false)
        //request.sortDescriptors = [sort]
        do {
            let pokemonContainers = try DatabaseHelper.sharedInstance.container.viewContext.fetch(request)
            return pokemonContainers
        } catch {
            print("fetch failed")
            return nil
        }
    }
    //
    //    func delete(sticker: Sticker) {
    //        container.viewContext.delete(sticker)
    //    }
    //
    //    func getPacks() -> [Pack]? {
    //        let request = NSFetchRequest<Pack>(entityName: "Pack")
    //        let sort = NSSortDescriptor(key: "create_date", ascending: false)
    //        request.sortDescriptors = [sort]
    //        do {
    //            let packs = try DatabaseHelper.sharedInstance.container.viewContext.fetch(request)
    //            return packs
    //        } catch {
    //            print("fetch failed")
    //            return nil
    //        }
    //    }
    //
    //    func getPacksBy(author: Author) -> [Pack]? {
    //        let request = NSFetchRequest<Pack>(entityName: "Pack")
    //        let packPredicate: NSPredicate = NSPredicate(format: "author == %@", author)
    //        request.predicate = packPredicate
    //        do {
    //            let packs = try DatabaseHelper.sharedInstance.container.viewContext.fetch(request)
    //            return packs
    //        } catch {
    //            print("fetch failed")
    //            return nil
    //        }
    //    }
    //
    //    func getPackBy(name: String) -> [Pack]? {
    //        let request = NSFetchRequest<Pack>(entityName: "Pack")
    //        let packPredicate: NSPredicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
    //        request.predicate = packPredicate
    //        do {
    //            let packs = try DatabaseHelper.sharedInstance.container.viewContext.fetch(request)
    //            return packs
    //        } catch {
    //            print("fetch failed")
    //            return nil
    //        }
    //    }
    //
    //    func getPackBy(id: String) -> Pack? {
    //        let request = NSFetchRequest<Pack>(entityName: "Pack")
    //        let packPredicate: NSPredicate = NSPredicate(format: "id == %@", id)
    //        request.predicate = packPredicate
    //        do {
    //            let packs = try DatabaseHelper.sharedInstance.container.viewContext.fetch(request)
    //            return packs[0]
    //        } catch {
    //            print("fetch failed")
    //            return nil
    //        }
    //    }
}
