//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Daniel Dickey on 4/27/21.
//

import CoreData

class TaskController {
    
    // MARK: - Properties
    
    static var shared = TaskController()
    var tasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {

        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
        
    }()
    
    // MARK: - Functions
    
    func fetchTasks() {
        let fetchedTasks = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        tasks = fetchedTasks
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        CoreDataStack.saveContext()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }

}
