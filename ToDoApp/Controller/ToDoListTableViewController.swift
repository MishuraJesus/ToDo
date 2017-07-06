//
//  ToDoListTableViewController.swift
//  ToDoApp
//
//  Created by MikhailB on 06/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var todos: [ToDo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleToDos()
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    struct PropertyKeys {
        static let cellReuseIdentifier = "ToDoCell"
    }
    
    // If there are no ToDos in the list by launching, array will have example todos, which were created manually
    func exampleToDos() {
        if todos == nil {
            todos = ToDo.exampleToDos
        }
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    // MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    //MARK: - TableView Cell Configuration
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cellReuseIdentifier) as? ToDoCell else { fatalError("Can not create deque reusable cell with identifier") }
        let todo = todos[indexPath.row]
        cell.toDoCellConfiguration(title: todo.title, dueDateString: dateToString(date: todo.dueDate), isComplete: todo.isComplete)
        return cell
    }
    
    //MARK: - Edit Support
    // Add support to edit the table view(delete, insert)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Allow editing the table view
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: - Reorder Cell Support
    // Allow to move cells
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Describe how to move the cell
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoToMove = todos[sourceIndexPath.row]
        todos.remove(at: sourceIndexPath.row)
        todos.insert(todoToMove, at: destinationIndexPath.row)
    }
}
