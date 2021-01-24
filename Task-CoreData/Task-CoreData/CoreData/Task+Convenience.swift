//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by Devin Flora on 1/22/21.
//

import CoreData

extension Task {
    @discardableResult convenience init(name: String, notes: String, dueDate: Date, isComplete: Bool = false, uuid: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
        self.uuid = uuid
    }
}//End of Extension
