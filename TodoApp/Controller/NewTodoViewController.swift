//
//  NewTodoViewController.swift
//  TodoApp
//
//  Created by Takeshi Akutsu on 2018/06/23.
//  Copyright © 2018年 Takeshi Akutsu. All rights reserved.
//

import UIKit

class NewTodoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(self.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(self.save))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.descriptionView.layer.cornerRadius = 5.0
        self.descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        self.descriptionView.layer.borderWidth = 1.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.todoField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        if self.todoField.text!.isEmpty {
            let alertView = UIAlertController(title: "ERROR", message: "タイトルが記入されていません", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        } else {
            let todo = Todo()
            todo.title = self.todoField.text!
            todo.descript = descriptionView.text
            todo.priority = TodoPriority(rawValue: self.prioritySegment.selectedSegmentIndex)!
            self.todoCollection.addTodoCollection(todo: todo)
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.todoField.resignFirstResponder()
        self.descriptionView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.todoField.resignFirstResponder()
        return true
    }
}
