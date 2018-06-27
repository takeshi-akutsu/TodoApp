//
//  TodoCollection.swift
//  TodoApp
//
//  Created by Takeshi Akutsu on 2018/06/23.
//  Copyright © 2018年 Takeshi Akutsu. All rights reserved.
//

import UIKit

class TodoCollection: NSObject {
    var todos: [Todo] = []
    static let sharedInstance = TodoCollection()
    
    func addTodoCollection(todo: Todo) {
        self.todos.append(todo)
        self.save()
    }
    
    func save() {
        var todoList: [Dictionary<String, AnyObject>] = []
        for todo in todos {
            let todoDic = TodoCollection.convertDictionary(todo: todo)
            todoList.append(todoDic)
        }
        let defaults = UserDefaults.standard
        defaults.set(todoList, forKey: "todoLists")
        defaults.synchronize()
    }
    
    
    func fetchTodos() {
        let defaults = UserDefaults.standard
        if let todoList = defaults.object(forKey: "todoLists") as? [Dictionary<String, AnyObject>] {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(todoDic: todoDic)
                self.todos.append(todo)
            }
        }
        
    }
    
    class func convertDictionary(todo: Todo) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["title"] = todo.title as AnyObject
        dic["descript"] = todo.descript as AnyObject
        dic["priority"] = todo.priority.rawValue as AnyObject
        return dic
    }
    
    
    class func convertTodoModel(todoDic: Dictionary<String, AnyObject>) -> Todo {
        let todo = Todo()
        todo.title = todoDic["title"] as! String
        todo.descript = todoDic["descript"] as! String //疑問: descriptの内容はnilの可能性があるんじゃないの？強制アンラップで良いの？
//        print("descript: \(todoDic["descript"] as! String)")
        todo.priority = TodoPriority(rawValue: todoDic["priority"] as! Int)!
        return todo
    }
}
