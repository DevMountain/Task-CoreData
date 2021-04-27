//
//  DateFormatter.swift
//  Task-CoreData
//
//  Created by Daniel Dickey on 4/27/21.
//

import Foundation

extension Date {
    
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
    
}//End of extension
