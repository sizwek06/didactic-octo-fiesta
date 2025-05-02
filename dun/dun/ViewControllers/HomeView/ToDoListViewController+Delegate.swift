//
//  ToDoListViewController+Delegate.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/01.
//

extension ToDoListViewController: TodoItemsProtocol {
    func reloadView() {
        self.todoListCollectionView.reloadData()
    }
    
    func requestFirstTodo() {
        launchTodoAddAlert()
    }
}
