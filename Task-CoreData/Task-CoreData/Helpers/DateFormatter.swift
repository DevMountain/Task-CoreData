//
//  DateFormatter.swift
//  Task-CoreData
//
//  Created by Devin Flora on 1/24/21.
//

import Foundation

extension DateFormatter {
    
    static let taskDueDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}//End of Extension
