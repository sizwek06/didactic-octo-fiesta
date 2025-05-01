//
//  ToDoCollectionViewCell.swift
//  dūn
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {
    
    var todoItem: ToDoItem? {
        didSet {
            guard let todoItem = todoItem else { return }
            
            self.todoItemNameLabel.text = todoItem.description
            self.todoItemCompletionImageView.image = todoItem.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
        }
    }
    
    lazy var todoItemNameLabel: UILabel = {
        let label = UILabel()
        // TODO: Add font & textColor
        label.numberOfLines = 0
        label.textColor = UIColor(named: "AppearanceColor")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var todoItemCompletionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(named: "AppearanceColor")
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var todoItemDeletionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(named: "AppearanceColor")
        imageView.image = UIImage(systemName: "trash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        backgroundColor = .gray
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(todoItemNameLabel)
        addSubview(todoItemDeletionImageView)
        addSubview(todoItemCompletionImageView)
        
        todoItemDeletionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        todoItemDeletionImageView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        todoItemDeletionImageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        todoItemDeletionImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        todoItemCompletionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        todoItemCompletionImageView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        todoItemCompletionImageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        todoItemCompletionImageView.leftAnchor.constraint(equalTo: todoItemDeletionImageView.rightAnchor, constant: 85).isActive = true
        
        todoItemNameLabel.topAnchor.constraint(equalTo: todoItemDeletionImageView.bottomAnchor, constant: 20).isActive = true
        todoItemNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        todoItemNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        todoItemNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
//    func configureCell(description: String,
//                       isCompleted: Bool) {
//        
//        self.todoItem?.description = description
//        self.todoItem?.isCompleted = isCompleted
//    }
}
