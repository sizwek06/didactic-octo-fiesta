//
//  SingleLabelTableViewCell.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import UIKit

class SingleLabelCollectionViewCell: UICollectionViewCell {
    
    lazy var cellView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6.0
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 1.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        addSubview(cellLabel)

        cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        cellLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        cellLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
}
