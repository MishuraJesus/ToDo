//
//  ToDo.swift
//  ToDoApp
//
//  Created by MikhailB on 06/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import Foundation

class ToDo: NSObject, NSCoding {
    
    static let documentsDirectory =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("todos")
    
    struct PropertyKeys {
        static let title = "title"
        static let isComplete = "isComplete"
        static let dueDate = "dueDate"
        static let notes = "notes"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKeys.title)
        aCoder.encode(isComplete, forKey: PropertyKeys.isComplete)
        aCoder.encode(dueDate, forKey: PropertyKeys.dueDate)
        aCoder.encode(notes, forKey: PropertyKeys.notes)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKeys.title) as? String,let dueDate = aDecoder.decodeObject(forKey: PropertyKeys.dueDate) as? Date else { return nil }
        
        let isComplete = aDecoder.decodeBool(forKey: PropertyKeys.isComplete)
        let notes = aDecoder.decodeObject(forKey: PropertyKeys.notes)
            as? String
        
        self.init(title: title, isComplete: isComplete, dueDate:
            dueDate, notes: notes)
    }
    
    // Save all reminders locally
    static func saveToDos(todos: [ToDo]) {
        NSKeyedArchiver.archiveRootObject(todos, toFile: ToDo.archiveURL.path)
    }
    
    // Load all reminders from files on a device
    static func loadToDos() -> [ToDo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.archiveURL.path) as? [ToDo]
    }
    
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
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
}
