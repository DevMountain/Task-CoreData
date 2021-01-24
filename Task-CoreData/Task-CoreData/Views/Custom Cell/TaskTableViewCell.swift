//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Devin Flora on 1/22/21.
//

import UIKit

// MARK: - Protocol
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: TaskCompletionDelegate?
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(self)
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        taskDueDateLabel.text = DateFormatter.taskDueDate.string(from: task.dueDate ?? Date())
        
        if task.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
}//End of Class
