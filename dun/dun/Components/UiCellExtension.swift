//
//  UiCellExtension.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import UIKit

extension UITableViewCell {
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public static var identifier: String {
        return String(describing: self)
    }
}
