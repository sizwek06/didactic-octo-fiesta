//
//  ToDoItem.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation

struct ToDoItem {
    
    var description: String!
    var isCompleted: Bool!
    
    public init(todoDescription: String,
                isCompleted: Bool) {
        
        self.description = todoDescription
        self.isCompleted = isCompleted
    }
}
