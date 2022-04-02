//
//  DefaultCollectionViewCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 01/03/2022.
//

import UIKit

class DefaultCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "DefaultCollectionViewCell"
    
    let containerView  = DefaultView(viewColor: .clear, viewRaduis: 15)
    let cellImage      = DefaultImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContainerView()
        configureCellImage()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setCell(imageName: String){
        cellImage.downloadImg(from: imageName)
    }

    private func configureContainerView(){
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
    
    private func configureCellImage(){
        containerView.addSubview(cellImage)
        cellImage.layer.cornerRadius = 15
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            cellImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cellImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cellImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
}
