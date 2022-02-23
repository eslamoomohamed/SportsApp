//
//  SportCollectionViewCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    static let reuseID = "SportCollectionViewCell"
    
    let containerView  = DefaultView(viewColor: .lightGray, viewRaduis: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .green
        configureContainerView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func configureContainerView(){
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    

}
