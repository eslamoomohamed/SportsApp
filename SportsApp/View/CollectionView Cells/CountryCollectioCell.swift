//
//  CountryCollectioCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 27/02/2022.
//

import UIKit

class CountryCollectioCell: UICollectionViewCell {
    
    
    static let reuseID    = "CountryCollectioCell"
    
    let countryImg = DefaultImageView(frame: .zero)
    let countryTitle     = TitleLabel(textAlignment: .center, fontSize: 16, fontColor: .black)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAvaterImg()
        configureFollowerTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setCell(country: String){
        
        countryTitle.text = country
//        countryImg.downloadImg(from: )
        
    }

    func setCellWithUrl(country: String, Url:String){
        
        countryTitle.text = country
        countryImg.downloadImg(from: Url)
        
    }

    
    
    
    private func configureAvaterImg(){
        
        contentView.addSubview(countryImg)
        
        
        NSLayoutConstraint.activate([
        
            countryImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            countryImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            countryImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            countryImg.heightAnchor.constraint(equalTo: countryImg.widthAnchor)
        
        
        ])
        
        
    }
    
    
    
    
    private func configureFollowerTitle(){
        
        contentView.addSubview(countryTitle)
        
        NSLayoutConstraint.activate([
            
            countryTitle.topAnchor.constraint(equalTo: countryImg.bottomAnchor, constant: 12),
            countryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            countryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            countryTitle.heightAnchor.constraint(equalToConstant: 20)
        
        
        ])
        
        
        
    }
    
    
    
    
}

