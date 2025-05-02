//
//  TodoItemsViewModel.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation

final class TodoItemsViewModel {
    
    var persistedTodoItemsManager: PersistedTodoItemsProtocol!
    var delegate: TodoItemsProtocol!
    
    var todoArray: [ToDoItem] = []
    var completedArray: [ToDoItem] = []
    
    init(persistedTodoItemsManager: PersistedTodoItemsProtocol!,
         delegate: TodoItemsProtocol!) {
        self.persistedTodoItemsManager = persistedTodoItemsManager
        self.delegate = delegate
    }
    
    func addTodoItem(items: [ToDoItem]) {
        let todoItemsStored = UserDefaults.standard.bool(forKey: TodoStrings.todoStoredKey)
        
        if todoItemsStored {
            self.persistedTodoItemsManager.clearTodoItemsData(isCompletedItems: false)
            self.resetArrays()
        }
        
        self.persistedTodoItemsManager.saveToDoItemsToCoreData(todoItems: items, isCompletedItems: false)
        print("Saved to Array Entities, new array: \(self.todoArray)")
        print("New Array: \(items)")
        
        UserDefaults.standard.set(true, forKey: TodoStrings.todoStoredKey)
        retrieveStoredData()
    }
    
    func retrieveStoredData() {
        let todoItemsStored = UserDefaults.standard.bool(forKey: TodoStrings.todoStoredKey)
        
        if todoItemsStored {
            let todoItems = persistedTodoItemsManager.fetchPersistedTodoItems(isCompletedItems: false)
            let completedItems = persistedTodoItemsManager.fetchPersistedTodoItems(isCompletedItems: true)
            
            if todoItems.isEmpty {
                self.requestFirstTodo()
            }
            
            self.todoArray = todoItems
            self.completedArray = completedItems
            print("Current Array Entities: \(self.todoArray)")
        } else {
            self.requestFirstTodo()
        }
        
        self.delegate.reloadView()
    }
    
    func requestFirstTodo() {
        DispatchQueue.main.async {
            self.delegate.requestFirstTodo()
        }
    }
    
    func resetArrays() {
        self.todoArray = []
        self.completedArray = []
    }
}
