//
//  LeagueCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 24/02/2022.
//

import UIKit
import CoreData

class LeagueCell: UITableViewCell {


    static let reuseID = "LeagueCell"
    
    let shared         = NetworkManager.shared
    let cellView       = DefaultView(viewColor: .lightGray, viewRaduis: 20)
    let imageView0     = DefaultImageView(frame: .zero)
    let imageView1     = UIImageView()
    let titleLabel     = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureCellView()
        configureImageView0()
        configureImageView1()
        configureTitle()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell(with info:Leagues ){
        
        shared.downloadImg(from: info.strBadge ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView0.image = image
                }
            case .failure(let error):
                print(error)
//                self.imageView0.image = UIImage(named: "logo")

            }
        }
//        imageView1.image = UIImage(named: viewInfo.imageName1)
        titleLabel.text  = info.strLeagueAlternate

        
    }
    
    
    func setCellWithCoreData(with info: LeaugesEntity){
        
        print(info.strBadge)
        shared.downloadImg(from: info.strBadge ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView0.image = image
                }
            case .failure(let error):
                print(error)
//                self.imageView0.image = UIImage(named: "logo")

            }
        }
//        imageView1.image = UIImage(named: viewInfo.imageName1)
        titleLabel.text  = info.strLeague

        
    }
    
    
    func configureCellView(){
        
        contentView.addSubview(cellView)
        cellView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
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
//        imageView0.image       = UIImage(named: "logo")
//        imageView0.contentMode = .center
//        imageView0.backgroundColor = .brown
        
        NSLayoutConstraint.activate([
        
            imageView0.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            imageView0.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            imageView0.heightAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.1),
            imageView0.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.1)
        
        ])
        
        
    }
    
    func configureTitle(){
        
        cellView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .secondaryLabel

        
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView0.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -25),
            titleLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),

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

    
    
    

}
