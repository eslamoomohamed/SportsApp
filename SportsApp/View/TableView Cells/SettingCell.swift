//
//  SettingCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import UIKit

class SettingCell: UITableViewCell {

    
    static let reuseID = "settingCell"
    
    
    let cellView       = DefaultView(viewColor: #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1), viewRaduis: 20)
    let imageView0     = UIImageView()
    let imageView1     = UIImageView()
    let titleLabel     = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        configureCellView()
        configureImageView0()
        configureImageView1()
        configureTitle()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell(viewInfo: SettingInfo){
        
        imageView0.image = UIImage(named: viewInfo.imageName0)
        imageView1.image = UIImage(named: viewInfo.imageName1)
        titleLabel.text  = viewInfo.title

        
    }
    
    
    
    func configureCellView(){
        
        contentView.addSubview(cellView)
//        cellView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
        cellView.layer.cornerRadius = 15
        NSLayoutConstraint.activate([
        
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),

        ])
        
    }
    
    
    func configureImageView0(){
        
        cellView.addSubview(imageView0)
        imageView0.translatesAutoresizingMaskIntoConstraints = false
        imageView0.image = UIImage(named: "icon-sign-out")
        imageView0.contentMode = .center
        
        NSLayoutConstraint.activate([
        
            imageView0.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            imageView0.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            imageView0.heightAnchor.constraint(equalToConstant: 40),
            imageView0.widthAnchor.constraint(equalTo: imageView0.heightAnchor)
        
        ])
        
        
    }
    
    func configureImageView1(){
        
        cellView.addSubview(imageView1)
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView1.image = UIImage(named: "icon-chevron")
        imageView1.contentMode = .center
        
        NSLayoutConstraint.activate([
        
            imageView1.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            imageView1.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            imageView1.heightAnchor.constraint(equalToConstant: 40),
            imageView1.widthAnchor.constraint(equalTo: imageView1.heightAnchor)
        
        ])
        
        
    }

    
    
    func configureTitle(){
        
        cellView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .secondaryLabel

        
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 45),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),

        ])
        
        
    }

    
    
}
