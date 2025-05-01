//
//  ViewController.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var todoList: [ToDoItem]? = [
                                ToDoItem(todoDescription: "Test 1", isCompleted: true),
                                ToDoItem(todoDescription: "Test 2", isCompleted: false),
                                ToDoItem(todoDescription: "Test 3", isCompleted: true),
                                ToDoItem(todoDescription: "Test 4", isCompleted: false)
                                ]

    class func create() -> ToDoListViewController {
        let toDoListViewController = ToDoListViewController()
        
        return toDoListViewController
    }
    
    lazy var modulesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 12.0, right: 16.0)
        collectionView.register(ToDoCollectionViewCell.self,
                                forCellWithReuseIdentifier: ToDoCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TodoStrings.todoListTitle
        
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(modulesCollectionView)
        
        modulesCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        modulesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        modulesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        modulesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        modulesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    enum todoListSections: Int, CaseIterable {
        case quote
        case todoList
        case completedList
        case newTodo
    }
}

