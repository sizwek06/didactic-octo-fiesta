//
//  ToDoItem.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation

struct ToDoItem {
    
    var itemDescription: String!
    var isCompleted: Bool!
    
    public static var todoEntityName: String {
        return TodoStrings.todoEntityKey
    }
    
    public static var completedTodoEntityName: String {
        return TodoStrings.completedToDoEntityKey
    }
    
    public init(todoDescription: String,
                isCompleted: Bool) {
        
        self.itemDescription = todoDescription
        self.isCompleted = isCompleted
    }
}
