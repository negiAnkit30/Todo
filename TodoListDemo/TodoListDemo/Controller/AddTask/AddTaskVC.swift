//
//  AddTaskVC.swift
//  TodoListDemo
//
//  Created by H S Negi on 05/06/23.
//

import UIKit
import Toast_Swift
import CoreData
import MaterialComponents.MaterialTextControls_OutlinedTextFields


class AddTaskVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var titleTF: MDCOutlinedTextField!
    @IBOutlet weak var amPmTextField: MDCOutlinedTextField!
    @IBOutlet weak var timeTF: MDCOutlinedTextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    //MARK: - Property
    var selectedTime:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setUpFloatingTextField()
        setupPickerView()
    }
    
    //MARK: - Floating TextField Setup
    func setUpFloatingTextField() {
        configureOutlinedTextField(titleTF, label: "Title", placeholder: "Enter title")
        configureOutlinedTextField(amPmTextField, label: "AM/PM", placeholder: "AM/PM")
        configureOutlinedTextField(timeTF, label: "Time", placeholder: "Enter time")
        
        titleTF.setOutlineColor(UIColor.lightGray, for: .normal)
        amPmTextField.setOutlineColor(UIColor.lightGray, for: .normal)
        timeTF.setOutlineColor(UIColor.lightGray, for: .normal)
    }
    
    func configureOutlinedTextField(_ textField: MDCOutlinedTextField, label: String, placeholder: String) {
        textField.label.text = label
        textField.placeholder = placeholder
        textField.sizeToFit()
    }
    
    //MARK: - Time Picker Setup
    func setupPickerView() {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        timeTF.inputView = timePicker
    }
    
   
    //MARK: - @IBAction
    @IBAction func addBtnAction(_ sender: UIButton) {
        guard let title = titleTF.text, !title.isEmpty else {
            self.view.makeToast(AlertMessage.emptyTitleField)
            return
        }
        guard let time = timeTF.text, !time.isEmpty else {
            self.view.makeToast(AlertMessage.emptyTimeField)
            return
        }
        guard let checkAMPm = amPmTextField.text, !checkAMPm.isEmpty else {
            self.view.makeToast(AlertMessage.emptyAmPmField)
            return
        }
        let todoItem = TodoListModel(title: title, dueDate: selectedTime, isCheck: false)
        DatabaseHandler.instance.createTodo(addTodo: todoItem)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        selectedTime = sender.date
        var timeString = dateFormatter.string(from: sender.date)
        let checkPeriod = timeString.contains("AM")
        if checkPeriod == true {
            amPmTextField.text = "AM"
        }else{
            amPmTextField.text = "PM"
        }
        if timeString.contains("AM") {
            timeString = timeString.replacingOccurrences(of: "AM", with: "")
        }else{
            timeString = timeString.replacingOccurrences(of: "PM", with: "")
        }
        timeTF.text = timeString
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
}






