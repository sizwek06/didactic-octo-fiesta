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

let dateLabel: UILabel = {
    let title = UILabel()
    title.text = "Today"
    title.textColor = .black
    title.backgroundColor = .clear
    title.font = UIFont(name: "Montserrat", size: 17)
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
}()

func setupHeaderViews()   {
    addSubview(dateLabel)

    dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    dateLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
}
