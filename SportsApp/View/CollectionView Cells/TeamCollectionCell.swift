//
//  TeamCollectionCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 28/02/2022.
//

import UIKit

class TeamCollectionCell: UICollectionViewCell {
    
    
    
    static let reuseID = "TeamCollectionCell"
    let cellView       = DefaultView(viewColor: .clear, viewRaduis: 15)
    var imageView      = DefaultImageView(frame: .zero)
    var teamName       = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .black)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell(team: Teams){
        imageView.downloadImg(from: team.strTeamBadge ?? "")
        teamName.text = team.strTeam
        
    }
    
    
    private func configure(){
        
        contentView.addSubview(cellView)
        imageView.contentMode = .scaleAspectFit
        
        teamName.textAlignment = .center
        cellView.addSubview(imageView)
        cellView.addSubview(teamName)
        cellView.addBorder()
        
        
        
        NSLayoutConstraint.activate([
        
            
//            cellView.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,constant: -25),
            
            teamName.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10 ),
            teamName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            teamName.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            
            
            
        ])
        
        
        
    }
    
}

    

