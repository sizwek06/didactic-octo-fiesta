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
        guard let todoList = todoList else { return 0 }
        
        var completedItems: [ToDoItem] = []
        var unCompletedItems: [ToDoItem] = []
        
        todoList.forEach { item in
             if item.isCompleted {
                 completedItems.append(item)
             } else {
                 unCompletedItems.append(item)
             }
         }
        
        switch todoListSections(rawValue: section) {
        case .completedList:
            return completedItems.count
        case .todoList:
            return unCompletedItems.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let todoItems = self.todoList else {
            return UICollectionViewCell()
        }
        
        var completedItems: [ToDoItem] = []
        var unCompletedItems: [ToDoItem] = []
        
       todoItems.forEach { item in
           item.isCompleted ? completedItems.append(item) : unCompletedItems.append(item)
        }
        
        switch todoListSections(rawValue: indexPath.section) {
            
        case .completedList:
            guard let todoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCollectionViewCell.identifier, for: indexPath) as? ToDoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            todoCollectionCell.todoItem = completedItems[indexPath.item]
            
           return todoCollectionCell
        case .todoList:
            guard let todoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCollectionViewCell.identifier, for: indexPath) as? ToDoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let todoItem = unCompletedItems[indexPath.item]
            todoCollectionCell.todoItem = todoItem
//            todoCollectionCell.configureCell(description: todoItem.description,
//                                             isCompleted: todoItem.isCompleted)
//            
            return todoCollectionCell
        default:
            guard let singleLabelCell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleLabelCollectionViewCell.identifier, for: indexPath) as? SingleLabelCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            singleLabelCell.cellLabel.text = "New Todo Item"
            singleLabelCell.cellLabel.textColor = .black
            
            return singleLabelCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {
            return UICollectionViewCell()
        }
        
        switch todoListSections(rawValue: indexPath.section) {
        case .completedList:
            header.dateLabel.text = "Completed"
            return header
        case .todoList:
            header.dateLabel.text = "To Do"
            return header
        default:
            header.dateLabel.text = "Add another?"
            
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch todoListSections(rawValue: indexPath.section) {
        case .completedList, .todoList:
            let cellWidth = UIScreen.main.bounds.width * 0.5 - 22.0
            let cellHeight = UIScreen.main.bounds.width * 0.5 + 20.0
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return CGSize(width: UIScreen.main.bounds.width - 24.0, height: 70.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 35.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}
