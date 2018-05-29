//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Aluno on 22/05/2018.
//  Copyright © 2018 Lucas. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var todo: ToDo?
    
    var isPickerHidden = true
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(86400)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(75)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [0,1]: //Due Date Cell
            return isPickerHidden ? normalCellHeight :
            largeCellHeight
        case [1,0]: //Notes Cell
            return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [0,1]:
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
