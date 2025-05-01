//
//  CollectionHeader.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import UIKit

class Header: UICollectionViewCell  {
    
    override init(frame: CGRect)    {
        super.init(frame: frame)
        setupHeaderViews()
    }
    
    lazy var headerLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont(name: "SFProRounded-Bold", size: 17)
        title.backgroundColor = .clear
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setupHeaderViews()   {
        addSubview(headerLabel)
        
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        headerLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
