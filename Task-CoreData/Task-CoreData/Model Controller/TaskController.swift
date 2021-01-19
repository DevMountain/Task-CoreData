//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Cameron Stuart on 1/19/21.
//

import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        Task(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
}
