//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Daniel Dickey on 4/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDetailTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Properties
    
    var task: Task?
    var date: Date?
  
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let newName = taskNameTextField.text, !newName.isEmpty else {return}
        
              let newNotes = taskDetailTextView.text
              let newDueDate = date
        
        if let task = task {
            TaskController.shared.update(task: task, name: newName, notes: newNotes, dueDate: newDueDate)
        } else {
            TaskController.shared.createTaskWith(name: newName, notes: newNotes, dueDate: newDueDate)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    
    // MARK: - Functions

    func updateViews() {
        
        if let task = task {
            taskNameTextField.text = task.name
            taskDetailTextView.text = task.notes
            taskDueDatePicker.date = task.dueDate ?? Date()
        }
        
    }
    
} //End of class
