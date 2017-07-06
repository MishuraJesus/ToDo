//
//  ToDo.swift
//  ToDoApp
//
//  Created by MikhailB on 06/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import Foundation

class ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    // Save all reminders locally
    func saveToDo(_ todos: [ToDo]) {
        
    }
    
    // Load all reminders from files on a device
    func loadToDo(_ todos: [ToDo]) {
        
    }
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
}
