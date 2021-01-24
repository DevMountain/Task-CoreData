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
    
    var tasks: [Task] = []
    
    var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()

    // MARK: - CRUD Methods
    func createTaskWith(name: String, notes: String, dueDate: Date) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    func update(task: Task, name: String, notes: String, dueDate: Date) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}//End of Class
