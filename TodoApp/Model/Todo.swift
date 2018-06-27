//
//  Todo.swift
//  TodoApp
//
//  Created by Takeshi Akutsu on 2018/06/23.
//  Copyright © 2018年 Takeshi Akutsu. All rights reserved.
//

import UIKit

enum TodoPriority: Int {
    case Low = 0
    case Middle = 1
    case High = 2
    
    func color() -> UIColor {
        switch self {
        case .Low:
            return UIColor.yellow
        case .Middle:
            return UIColor.green
        case . High:
            return UIColor.red
        }
    }
}

class Todo: NSObject {
    var title = ""
    var descript = ""
    var priority: TodoPriority = .Low
}
