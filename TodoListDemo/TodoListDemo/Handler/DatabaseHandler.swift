//
//  DatabaseHandler.swift
//  TodoListDemo
//
//  Created by H S Negi on 05/06/23.
//

import Foundation
import CoreData
import UIKit

class DatabaseHandler {
    static let instance = DatabaseHandler()
    private init() {}
    
    private var context:NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func createTodo(addTodo:TodoListModel) {
        let todoEntity = TodoList(context: context)
        todoEntity.title = addTodo.title
        todoEntity.dueDate = addTodo.dueDate
        todoEntity.isCheck = addTodo.isCheck
        saveContext()
    }
        
    func updateTodo(addTodo:TodoListModel,todoEntity:TodoList) {
        todoEntity.title = addTodo.title
        todoEntity.dueDate = addTodo.dueDate
        todoEntity.isCheck = addTodo.isCheck
        saveContext()
    }
    
    func fetchTodoListInfo() -> [TodoList] {
        var todoInfo:[TodoList] = []
        do {
            todoInfo = try context.fetch(TodoList.fetchRequest())
        }catch let error {
            print(error.localizedDescription)
        }
        return todoInfo
    }
    
    func deleteTodoItem(todoEntity:TodoList) {
        context.delete(todoEntity)
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
