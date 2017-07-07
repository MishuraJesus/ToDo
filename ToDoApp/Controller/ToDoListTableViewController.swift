//
//  ToDoListTableViewController.swift
//  ToDoApp
//
//  Created by MikhailB on 06/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, ToDoCellDelegate {
    
    var todos: [ToDo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = ToDo.loadToDos()
        exampleToDos()
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    struct PropertyKeys {
        static let cellReuseIdentifier = "ToDoCell"
        static let reminderDetailSegueIdentifier = "ReminderDetailSegue"
        static let unwindSaveNewToDoIdentifier = "SaveNewToDo"
    }
    
    // If there are no ToDos in the list by launching, array will have example todos, which were created manually
    func exampleToDos() {
        if todos == nil {
            todos = ToDo.exampleToDos
        }
    }
    
    // Translate Date format to String with special russian format
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    // Delegate method to get cell which was tapped to change todo.isComplete value
    func checkmarkButtonPressed(cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos: todos)
        }
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
        cell.delegate = self
        return cell
    }
    
    //MARK: - Edit Support
    // Add support to edit the table view(delete, insert)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        ToDo.saveToDos(todos: todos)
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
        ToDo.saveToDos(todos: todos)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Write segue
        if let newToDoTableViewController = segue.destination as? NewToDoTableViewController {
            guard segue.identifier == PropertyKeys.reminderDetailSegueIdentifier else { fatalError("reminderDetailSegueIdentifier fail") }
            guard let selectedRowIndexPath = tableView.indexPathForSelectedRow else { fatalError("selected row fail") }
            newToDoTableViewController.todo = todos[selectedRowIndexPath.row]
        }
    }
    
    // If was triggered by "Cancel" - just return to the list
    // If was triggered by "Save" - if founds seleceted row, then todo object was changed. Replace obkect and reload the cell. If it is a new object - append new object to array and insert new row with new indexpath
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard let newToDoTableViewController = segue.source as? NewToDoTableViewController else { return }
        if segue.identifier == PropertyKeys.unwindSaveNewToDoIdentifier {
            guard let todo = newToDoTableViewController.todo else { return }
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedRowIndexPath.row] = todo
                tableView.reloadRows(at: [selectedRowIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(todos: todos)
    }
}
