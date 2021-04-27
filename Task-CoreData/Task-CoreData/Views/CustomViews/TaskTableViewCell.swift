//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Daniel Dickey on 4/27/21.
//

import UIKit

protocol TaskCompletionDelgate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    
    // MARK: - Properties
    
    weak var delegate: TaskCompletionDelgate?
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(self)
        }
    }
    
    // MARK: - Functions
    
    func updateViews() {
        if let task = task {
            
            taskNameLabel.text = task.name
            completionButton.setImage(task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete"), for: .normal)
            dueDateLabel.text = task.dueDate?.formatToString()
        }
    }
    
}//End of class
