//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by Daniel Dickey on 4/27/21.
//

import CoreData

extension Task {
    
    convenience init(name: String, notes: String? = nil, dueDate: Date? = nil, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
    
    func add(taskWithName name: String, notes: String?, dueDate: Date?) {
        
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        
    }
    
    func fetchTasks() {
        
    }
    
}//End of extension
