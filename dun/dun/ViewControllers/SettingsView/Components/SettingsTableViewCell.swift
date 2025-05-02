//
//  SettingsTableViewCell.swift
//  Onews
//
//  Created by Sizwe Khathi on 2025/05/02.
//

import Foundation
import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var settingsSwitch: UISwitch!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var switchOption: SettingsOptions?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingsImageView.layer.cornerRadius = 8.0
        self.selectionStyle = .none
        self.backgroundColor = .none
        
        self.settingsLabel.textColor = UIColor(named: "AppearanceColor")
    }
    
    @IBAction func switchOn(_ sender: UISwitch) {
        
        guard let switchOption = switchOption else { return }
        
        switch switchOption {
        case .faceID:
            UserDefaults.standard.setValue(sender.isOn, forKey: TodoStrings.userDefaultBiometricsKey)
            DunBiometricState.sharedInstance.currentState = sender.isOn ? .faceIDRequired : .signedInWithFaceId
        default:
            break
        }
    }
    
    func setUpSettingsCell() {
        guard let switchOption = switchOption else { return }
        
        settingsLabel.text = switchOption.settingsLabelText
        
        switch switchOption {
        case .faceID:
            settingsSwitch.isOn = UserDefaults.standard.bool(forKey: TodoStrings.userDefaultBiometricsKey)
            
            switch DunBiometricState.sharedInstance.currentState {
            case .verifyFaceIdFailed, .signingInWithFaceId, .faceIDRequired:
                self.settingsSwitch.isEnabled = false
                self.settingsLabel.textColor = .gray
            default:
                self.settingsSwitch.isEnabled = true
            }
            
            settingsImageView.image = UIImage(systemName: "faceid")
            self.switchOption = .faceID
            settingsImageView.backgroundColor = UIColor.systemGreen
            self.accessoryType = .none
            self.settingsSwitch.isHidden = false
            
        case .purge:
            settingsImageView.backgroundColor = UIColor.red
            settingsImageView.image = UIImage(systemName: "trash.square")
            self.accessoryType = .none
            self.settingsSwitch.isHidden = true
        }
    }
}

enum SettingsOptions: Int, CaseIterable {
    case faceID
    case purge
    
    var settingsLabelText: String {
        switch self {
        case .purge: return "Delete All ToDo"
        case .faceID: return "FaceID"
        }
    }
}
