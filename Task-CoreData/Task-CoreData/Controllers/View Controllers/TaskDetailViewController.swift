//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Devin Flora on 1/22/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDate: UIDatePicker!
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        taskNotesTextView.layer.borderWidth = 1
    }
    
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    
    // MARK: - Actions
    @IBAction func dueDatePickerDateChanged(_ sender: UIDatePicker) {
        date = taskDueDate.date
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = taskTitleTextField.text, !title.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: title, notes: notes, dueDate: date ?? Date())
        } else {
            TaskController.shared.createTaskWith(name: title, notes: notes, dueDate: date ?? Date())
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    func updateViews() {
        if let task = task {
            taskTitleTextField.text = task.name
            taskNotesTextView.text = task.notes
            taskDueDate.date = task.dueDate ?? Date()
        }
    }
}//End of Class
