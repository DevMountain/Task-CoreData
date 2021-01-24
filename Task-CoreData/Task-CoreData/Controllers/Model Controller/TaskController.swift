//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Devin Flora on 1/22/21.
//

import CoreData

class TaskController {
    
    // MARK: - Properties
    static let shared = TaskController()
    
    var sections: [[Task]] {[incompleteTasks, completeTasks]}
    var incompleteTasks: [Task] = []
    var completeTasks: [Task] = []
    
    var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()

    // MARK: - CRUD Methods
    func createTaskWith(name: String, notes: String, dueDate: Date) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        incompleteTasks.append(newTask)
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        incompleteTasks = tasks.filter{ !$0.isComplete }
        completeTasks = tasks.filter{ $0.isComplete }
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    func updateTaskCompletion(task: Task) {
        if task.isComplete {
            if let index = incompleteTasks.firstIndex(of: task) {
                incompleteTasks.remove(at: index)
                completeTasks.append(task)
            }
        } else {
            if let index = completeTasks.firstIndex(of: task) {
                completeTasks.remove(at: index)
                incompleteTasks.append(task)
            }
        }
        CoreDataStack.saveContext()
    }
    
    func update(task: Task, name: String, notes: String, dueDate: Date) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
        fetchTasks()
    }
}//End of Class
