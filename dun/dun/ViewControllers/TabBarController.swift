//
//  TabBarController.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import UIKit

class ToDoTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedIndex = 0
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch tabBar.selectedItem?.title {
        case TodoStrings.todoListTitle:
            self.selectedIndex = 0
        case TodoStrings.settingsViewTitle:
            self.selectedIndex = 1
        default:
            break
        }
    }
    
    func setupTabBar() {
        let todoListViewController = ToDoListViewController.create()
        let todoListNavigationController = UINavigationController(rootViewController: todoListViewController)
        todoListNavigationController.title = TodoStrings.todoListTitle
        
        let settingsViewController = SettingsViewController.create()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.title = TodoStrings.settingsViewTitle
        
        todoListNavigationController.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        todoListNavigationController.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.clipboard.fill")
        
        settingsNavigationController.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsNavigationController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        
        self.tabBar.tintColor = UIColor(named: "AppearanceColor")
        self.setViewControllers([todoListNavigationController, settingsNavigationController], animated: true)
    }
}
