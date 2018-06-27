//
//  TodoListTableViewController.swift
//  TodoApp
//
//  Created by Takeshi Akutsu on 2018/06/22.
//  Copyright © 2018年 Takeshi Akutsu. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: .plain, target: self, action: #selector(TodoListTableViewController.newTodo))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = editButtonItem
        todoCollection.fetchTodos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoCollection.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = self.todoCollection.todos[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil) //疑問: reuseIdentifierの記述必要？
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.descript
        let priorityIcon = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        priorityIcon.layer.cornerRadius = 6
        priorityIcon.backgroundColor = todo.priority.color()
        cell.accessoryView = priorityIcon
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.todoCollection.todos.remove(at: indexPath.row)
            self.todoCollection.save()
            tableView.deleteRows(at: [indexPath], with: .middle)
        case .insert:
            return
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = self.todoCollection.todos[sourceIndexPath.row]
        self.todoCollection.todos.remove(at: sourceIndexPath.row)
        self.todoCollection.todos.insert(todo, at: destinationIndexPath.row)
        self.todoCollection.save()
    }
    
    @objc func newTodo() {
        self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
    }

}
