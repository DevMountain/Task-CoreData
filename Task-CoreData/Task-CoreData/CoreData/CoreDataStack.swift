//
//  CoreDataStack.swift
//  Task-CoreData
//
//  Created by Cameron Stuart on 1/19/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Task_CoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
