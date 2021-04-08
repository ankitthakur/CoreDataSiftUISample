//
//  CoreDataManager.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 02/04/21.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    //Initializer access level change now
    fileprivate init() {}
    
    
    // MARK: - Core Data stack
    lazy var viewContext: NSManagedObjectContext = {return self.persistentContainer.viewContext}()
    lazy var persistentContainer: NSPersistentContainer = {return createPersistentContainer()}()
    
    
    private func createPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "Sample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    func backgroundManagedObjectContext() -> NSManagedObjectContext {
        let backgroundmanagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundmanagedObjectContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        backgroundmanagedObjectContext.parent = self.viewContext
        return backgroundmanagedObjectContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if self.viewContext.hasChanges {
            self.viewContext.performAndWait {
                do {
                    // Saves the data from the child to the main context
                    try self.viewContext.save()
                } catch let error {
                    print("File \(type(of: self)) -> Function: \(#function) -> Line: \(#line) -> Failure to save context: \(error)")
                }
            }
        }
    }
    
    func saveBackgroundContext(inContext pvtManagedObjectContext:NSManagedObjectContext) -> Bool {
        var status = true
        if pvtManagedObjectContext.hasChanges {
            
            do {
                try pvtManagedObjectContext.save()
                self.viewContext.performAndWait {
                    do {
                        // Saves the data from the child to the main context
                        try self.viewContext.save()
                    } catch let error {
                        print("File \(type(of: self)) -> Function: \(#function) -> Line: \(#line) -> Failure to save context: \(error)")
                    }
                }
            } catch let error {
                status = false
                print("File \(type(of: self)) -> Function: \(#function) -> Line: \(#line) -> error -> \(error)")
            }
        }
        
        
        return status
    }
    
}
