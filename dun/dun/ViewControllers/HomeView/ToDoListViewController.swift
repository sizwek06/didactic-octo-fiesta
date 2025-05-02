//
//  ViewController.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var viewModel: TodoItemsViewModel!
    let biometricAuthManager = BiometricAuthManager()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        verifyBiometricState()
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
    
    func setupView() {
        switch DunBiometricState.sharedInstance.currentState {
        case .verifyFaceIdFailed, .signingInWithFaceId, .faceIDRequired:
            break
        case .signedInWithFaceId, .signedInNoFaceId:
            DunBiometricState.sharedInstance.currentState = .signedInWithFaceId
            
            self.viewModel.retrieveStoredData()
            
            self.setupCollectionView()
        }
    }
    
    func verifyBiometricState() {
        
        if UserDefaults.standard.bool(forKey: TodoStrings.userDefaultBiometricsKey) {
            DunBiometricState.sharedInstance.currentState = .signingInWithFaceId
            
            biometricAuthManager.canEvaluate { (canEvaluate, _, _) in
                guard canEvaluate else {
                    DunBiometricState.sharedInstance.currentState = .signedInNoFaceId
                    return
                }
                
                biometricAuthManager.evaluate { [weak self] (success, _) in
                    guard let self else { return }
                    guard success else {
                        DunBiometricState.sharedInstance.currentState = .verifyFaceIdFailed
                        return
                    }
                    DunBiometricState.sharedInstance.currentState = .signedInWithFaceId
                    self.setupView()
                }
            }
        }
        self.setupView()
    }
    
    enum todoListSections: Int, CaseIterable {
        case todoList
        case completedList
        case newTodo
    }
}

