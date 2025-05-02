//
//  SettingsViewController+TableView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/02.
//

import Foundation
import UIKit

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? SettingsOptions.allCases.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleLabelTableViewCell.identifier) as? SingleLabelTableViewCell
            else { return UITableViewCell() }
            
            cell.signOutLabel.text = TodoStrings.settingsViewSubtitle
            cell.signOutLabel.textColor = .black
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as? SettingsTableViewCell else { return UITableViewCell() }
            
            switch SettingsOptions(rawValue: indexPath.row) {
            case .faceID:
                cell.switchOption = .faceID
                cell.setUpSettingsCell()
                
                return cell
            case .purge:
                cell.switchOption = .purge
                cell.setUpSettingsCell()
                
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            switch DunBiometricState.sharedInstance.currentState {
            case .signingInWithFaceId, .verifyFaceIdFailed, .faceIDRequired:
                return ""
            default:
                return "Settings"
            }
        } else {
            return ""
        }
    }
}
