//
//  TodoListVC.swift
//  TodoListDemo
//
//  Created by H S Negi on 05/06/23.
//

import UIKit

class TodoListVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var toDoListTblvw: UITableView!
    @IBOutlet weak var containerView: UIView!
    private var todoListArr:[TodoList] = []
    
    //MARK: - Property
    var selectedItem:TodoList!
    var selectedIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTblVw()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoListArr = DatabaseHandler.instance.fetchTodoListInfo()
        toDoListTblvw.reloadData()
        heightForView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightForView()
    }
    

    //MARK: - Container Height Setup
    func heightForView() {
        if todoListArr.isEmpty {
            let contentSize = toDoListTblvw.contentSize
            containerView.frame.size.height = contentSize.height
        }else{
            let contentSize = toDoListTblvw.contentSize
            containerView.frame.size.height = contentSize.height + 10.0
        }
    }
    
    //MARK: - Tableview Setup
    func setupTblVw() {
        toDoListTblvw.register(UINib(nibName: "TodoContentTblVwCell", bundle: nil), forCellReuseIdentifier: "TodoContentTblVwCell")
        toDoListTblvw.delegate = self
        toDoListTblvw.dataSource = self
    }
    
    //MARK: - @IBAction
    @IBAction func navToAddTaskVC(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddTaskVC") as! AddTaskVC
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: - Tableview delegate and datasource
extension TodoListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoContentTblVwCell") as? TodoContentTblVwCell else{
            return UITableViewCell()
        }
        let list = todoListArr[indexPath.row]
        cell.checkBtn.tag = indexPath.row
        cell.checkBtn.addTarget(self, action: #selector(didTapOnCheckBtn), for: .touchUpInside)
        cell.titleLbl.text = list.title
        if let date = list.dueDate {
            cell.timeLbl.text =  UtilityClass.getTimeInStringFormat(dueDate: date)
        }
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(didTapOnDeleteBtn), for: .touchUpInside)
        if list.isCheck == true {
            cell.titleLbl.lineDrawnInTextMiddle()
            cell.checkBtn.setImage(UIImage(named: "checkVector"), for: .normal)
        }else{
            cell.checkBtn.setImage(UIImage(named: "Vector"), for: .normal)
        }
        let currentDate = Date()
        if let date = list.dueDate {
            if currentDate > date && list.isCheck == false{
                cell.statusLbl.text = "Pending"
                cell.statusLbl.alpha = 1
                cell.titleLbl.textColor = UIColor.red
            }else{
                cell.statusLbl.alpha = 0
                cell.titleLbl.textColor = UIColor.black
            }
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func didTapOnDeleteBtn(sender:UIButton) {
        selectedIndex = sender.tag
        let list = todoListArr[selectedIndex]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView
        selectedItem = list
        vc.delegate = self
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    
    @objc func didTapOnCheckBtn(sender:UIButton) {
        selectedIndex = sender.tag
        let list = todoListArr[selectedIndex]
        if list.isCheck == false {
            list.isCheck = true
            let model = TodoListModel(title: list.title, dueDate: list.dueDate, isCheck: true)
            DatabaseHandler.instance.updateTodo(addTodo: model, todoEntity: list)
        }
        toDoListTblvw.reloadData()
    }
}

//MARK: - Delete TODO Item from List Protocol
extension TodoListVC:DeleteTodoIteemProtocol {
    func deleteItemFromList(checkOkPress: Bool) {
        if checkOkPress == true {
            DatabaseHandler.instance.deleteTodoItem(todoEntity: selectedItem)
            todoListArr.remove(at: selectedIndex)
            toDoListTblvw.reloadData()
            heightForView()
        }
    }
}

