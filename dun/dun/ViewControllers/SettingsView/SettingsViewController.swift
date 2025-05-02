//
//  SettingsViewController.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import UIKit

class SettingsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        
        table.refreshControl = UIRefreshControl()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let persistedTodoItemsManager = PersistedTodoItemsImplementation()
    
    class func create() -> SettingsViewController {
        let settingsViewController = SettingsViewController()
        
        return settingsViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = TodoStrings.settingsViewTitle
        tableView.isScrollEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.setUpView()
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
        self.tableView.register(SingleLabelTableViewCell.self, forCellReuseIdentifier: SingleLabelTableViewCell.identifier)
        
        view.addSubview(tableView)
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func setUpView() {
        UserDefaults.standard.synchronize()
        
        if UserDefaults.standard.bool(forKey: TodoStrings.userDefaultBiometricsKey) {
            DunBiometricState.sharedInstance.currentState = DunBiometricState.sharedInstance.currentState == .faceIDRequired ? .faceIDRequired : DunBiometricState.sharedInstance.currentState
        }
        
        self.setupTableView()
    }
}
