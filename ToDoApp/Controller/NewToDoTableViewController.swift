//
//  NewToDoTableViewController.swift
//  ToDoApp
//
//  Created by MikhailB on 07/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import UIKit

class NewToDoTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var todo: ToDo?
    var isDatePickerVisible: Bool! {
        didSet {
            dueDatePicker.isHidden = !isDatePickerVisible
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        updateView()
    }
    
    // If user wants to see details or change existing reminder data this function will update all view according to "todo" passed values
    func updateView() {
        guard let detailToDo = todo else
        {
            dueDateLabel.text = dateToString(date: Date())
            dueDatePicker.date = Date()
            isDatePickerVisible = false
            return
        }
        titleTextField.text = detailToDo.title
        dueDateLabel.text = dateToString(date: detailToDo.dueDate)
        isDatePickerVisible = false // Hide date picker
        if detailToDo.isComplete {
            isCompleteButton.setImage(#imageLiteral(resourceName: "Checked"), for: .selected)
            isCompleteButton.isSelected = true
        } else {
            isCompleteButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            isCompleteButton.isSelected = false
        }
        guard let detailToDoNotes = detailToDo.notes else { return }
        notesTextView.text = detailToDoNotes
    }
    
    // Change row height for cell with date picker.
    // When date picker is hidden - row height is 44, shown - 200
    // Also change due date label text color, when picker is visible
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [1, 0]:
            if isDatePickerVisible {
                dueDateLabel.textColor = tableView.tintColor
                return 200.0
            } else {
                dueDateLabel.textColor = UIColor.black
                return 44.0
            }
        case [2, 0]:
            return 200.0
        default: return 44.0
        }
    }
    
    // Used to hide or show date picker, then updates tableView to update cell height
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            isDatePickerVisible = !isDatePickerVisible
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    // Translate Date format to String with special russian format
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    // Checks if title is empty, disable Save button, otherwise enable
    func updateSaveButtonState() {
        guard let text = titleTextField.text else {
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = text.isEmpty ? false : true
    }
    
    // When user hits Return keyboard will be hidden
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dueDatePickerValueChanged(_ sender: UIDatePicker) {
        dueDateLabel.text = dateToString(date: sender.date)
    }
    
    // Triggered when title changed to call function whic change Save button state
    @IBAction func titleTextFiledEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // When isComplete button tapped fucnction change image of the button and change isSelected value
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        //print("NewToDo| isComplete START tapped. isComplete button selected = \(isCompleteButton.isSelected)")
        if isCompleteButton.isSelected {
            isCompleteButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            isCompleteButton.isSelected = false
        } else {
            isCompleteButton.setImage(#imageLiteral(resourceName: "Checked"), for: .selected)
            isCompleteButton.isSelected = true
        }
        //print("NewToDo| isComplete tapped. isComplete button selected = \(isCompleteButton.isSelected)")
    }
    
    // Preparation for unwind segue, create todo object to pass it later to the list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveNewToDo" {
            todo = ToDo(title: titleTextField.text!, isComplete: isCompleteButton.isSelected, dueDate: dueDatePicker.date, notes: notesTextView.text)
        }
    }
}
