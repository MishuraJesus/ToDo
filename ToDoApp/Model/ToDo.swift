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
    
    static var exampleToDos: [ToDo] {
        let todo1 = ToDo(title: "One", isComplete: true, dueDate: Date(), notes: nil)
        let todo2 = ToDo(title: "Two", isComplete: false, dueDate: Date(), notes: nil)
        let todo3 = ToDo(title: "Three", isComplete: true, dueDate: Date(), notes: nil)
        
        return [todo1, todo2, todo3]
    }
    
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
