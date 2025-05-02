//
//  ToDoListViewController+CollectionView.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import UIKit

extension ToDoListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return todoListSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch todoListSections(rawValue: section) {
        case .completedList:
            return self.viewModel.completedArray.isEmpty ? 1 : self.viewModel.completedArray.count
        case .todoList:
            return self.viewModel.todoArray.isEmpty ? 1 : self.viewModel.todoArray.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("ViewController ViewModel Array: \(self.viewModel.todoArray)")
        
        switch todoListSections(rawValue: indexPath.section) {
            
        case .completedList:
            if self.viewModel.completedArray.isEmpty {
                return self.createSingLabelCell(with: TodoStrings.noTodoItemsListText, indexPath: indexPath)
            } else {
                return self.createTodoCell(with: self.viewModel.completedArray[indexPath.item], indexPath: indexPath)
            }
        case .todoList:
            return self.viewModel.todoArray.isEmpty ? self.createSingLabelCell(with: TodoStrings.noTodoItemsListText, indexPath: indexPath) : self.createTodoCell(with: self.viewModel.todoArray[indexPath.item], indexPath: indexPath)
        default:
            return self.createSingLabelCell(with: TodoStrings.todoListButtonTitle, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {
            return UICollectionViewCell()
        }
        
        switch todoListSections(rawValue: indexPath.section) {
        case .completedList:
            header.headerLabel.text = "Completed"
            return header
        case .todoList:
            header.headerLabel.text = "To Do"
            return header
        default:
            header.headerLabel.text = "Add another?"
            
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch todoListSections(rawValue: indexPath.section) {
        case .completedList:
            return self.viewModel.completedArray.isEmpty ? self.returnSingleCellSize() : self.calculateCellSize()
        case .todoList:
            return self.viewModel.todoArray.isEmpty ? self.returnSingleCellSize() : self.calculateCellSize()
        default:
            return self.returnSingleCellSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 35.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch todoListSections(rawValue: indexPath.section) {
        case .todoList:
            if !self.viewModel.todoArray.isEmpty {
                self.returnUpdateAlert(itemPosition: indexPath.item)
            } else {
                self.launchTodoAddAlert()
            }
        case .completedList:
            if !self.viewModel.completedArray.isEmpty {
                let todoItem = self.viewModel.completedArray[indexPath.item]
                
                let alert = UIAlertController(title: "Delete \(todoItem.itemDescription ?? "Unknown Description")",
                                              message: "This action will permanently delete", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    
                    self.viewModel.completedArray.remove(at: indexPath.item)
                    self.viewModel.addTodoItem(items: self.viewModel.completedArray, isCompleted: true)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                
                self.present(alert, animated: true)
            }
        case .newTodo:
            self.launchTodoAddAlert()
        default:
            break
        }
    }
    
    func launchTodoAddAlert() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New",
                                      message: "Add new Item to get dūn!",
                                      preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            guard let self else { return }
            
            print("Old Count: \(self.viewModel.todoArray.count)")
            let newItem = ToDoItem(todoDescription: textField.text ?? TodoStrings.generalUnknownError,
                                   isCompleted: false)
            self.viewModel.todoArray.append(newItem)
            // TODO: Use a better placeholder for error handling
            print("New Item added onto Array: \(self.viewModel.todoArray)")
            print("New Count: \(self.viewModel.todoArray.count)")
            
            let newArray = self.viewModel.todoArray
            print("New Array: \(newArray)")
           
            self.viewModel.addTodoItem(items: newArray)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] action in
            guard let self else { return }
            
            self.dismiss(animated: true)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func createTodoCell(with: ToDoItem, indexPath: IndexPath) -> UICollectionViewCell {
        guard let todoCollectionCell = todoListCollectionView.dequeueReusableCell(withReuseIdentifier: ToDoCollectionViewCell.identifier, for: indexPath) as? ToDoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        todoCollectionCell.todoItem = with
        todoCollectionCell.itemPosition = indexPath.item
        
        return todoCollectionCell
    }
    
    func createSingLabelCell(with: String, indexPath: IndexPath, color: UIColor? = .black) -> UICollectionViewCell {
        guard let singleLabelCell = todoListCollectionView.dequeueReusableCell(withReuseIdentifier: SingleLabelCollectionViewCell.identifier, for: indexPath) as? SingleLabelCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        singleLabelCell.cellLabel.text = with
        singleLabelCell.cellLabel.textColor = color
        
        return singleLabelCell
    }
    
    func calculateCellSize() -> CGSize {
        let cellWidth = UIScreen.main.bounds.width * 0.5 - 22.0
        let cellHeight = UIScreen.main.bounds.width * 0.5 + 20.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func returnSingleCellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 24.0, height: 70.0)
    }
    
    func returnUpdateAlert(itemPosition: Int) {
        let todoItem = self.viewModel.todoArray[itemPosition]
        
        let alert = UIAlertController(title: "Update \(todoItem.itemDescription ?? "Unknown Todo name")",
                                      message: "Please select an option to continue", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Complete", style: .default, handler: { _ in

            self.viewModel.todoArray.remove(at: itemPosition)
            self.viewModel.completedArray.append(ToDoItem(todoDescription: todoItem.itemDescription,
                                                          isCompleted: true))
            
            self.viewModel.addTodoItem(items: self.viewModel.completedArray, isCompleted: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            
            self.viewModel.completedArray.remove(at: itemPosition)
            self.viewModel.addTodoItem(items: self.viewModel.todoArray, isCompleted: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
}
