//
//  ViewController.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var viewModel: TodoItemsViewModel!
    
    class func create() -> ToDoListViewController {
        let toDoListViewController = ToDoListViewController()
        let persistedTodoItemsManager = PersistedTodoItemsImplementation()
        
        toDoListViewController.viewModel = TodoItemsViewModel(persistedTodoItemsManager: persistedTodoItemsManager,
                                                              delegate: toDoListViewController)
        return toDoListViewController
    }
    
    lazy var todoListCollectionView: UICollectionView = {
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
        collectionView.register(SingleLabelCollectionViewCell.self,
                                forCellWithReuseIdentifier: SingleLabelCollectionViewCell.identifier)
        collectionView.register(Header.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TodoStrings.todoListTitle
        
        self.viewModel.retrieveStoredData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.resetArrays()
    }
    
    private func setupCollectionView() {
        view.addSubview(todoListCollectionView)
        
        todoListCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        todoListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        todoListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        todoListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        todoListCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    enum todoListSections: Int, CaseIterable {
        case todoList
        case completedList
        case newTodo
    }
}

