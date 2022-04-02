////
////  SportCollectionViewCell.swift
////  SportsApp
////
////  Created by eslam mohamed on 22/02/2022.
////
//
//import UIKit
//
//class SportCollectionViewCell: UICollectionViewCell {
//
//    static let reuseID = "SportCollectionViewCell"
//
//    let containerView  = DefaultView(viewColor: .clear, viewRaduis: 0)
//    let titleLabel     = TitleLabel(textAlignment: .center, fontSize: 40,fontColor: .white)
//    let cellImage      = DefaultImageView(frame: .zero)
//    let cellView       = DefaultView(viewColor: .lightText, viewRaduis: 0)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        contentView.backgroundColor = .green
//        configureContainerView()
//        configureCellImage()
//        configureTitleLabel()
//    }
//
//    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//
////    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
////        super.apply(layoutAttributes)
////
////        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
////        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
////
////        let delta = (featuredHeight - frame.height) / (featuredHeight - standardHeight)
////
////        let minAlpha: CGFloat = 0.3
////        let maxAlpha: CGFloat = 0.75
////
////        cellView.alpha = minAlpha + delta * (maxAlpha - minAlpha)
////
////        let scale = max(1 - delta, 0.5)
////        titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
////
////        titleLabel.alpha = 1 - delta
//////        speakerLabel.alpha     = 1 - delta
////    }
//
//
//    func configureCell(with sport: Sports){
//        titleLabel.text = sport.strSport
//        cellImage.downloadImg(from: sport.strSportThumb ?? "")
//    }
//
//
//    private func configureContainerView(){
//        contentView.addSubview(containerView)
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
//    }
//
//    private func configureTitleLabel(){
//        containerView.addSubview(titleLabel)
//        titleLabel.numberOfLines = 1
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 15),
////            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
////            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
////            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
//        ])
//    }
//
//    private func configureCellImage(){
//        containerView.addSubview(cellImage)
////        containerView.addSubview(cellView)
////        cellImage.alpha = 0.85
//        NSLayoutConstraint.activate([
//            cellImage.topAnchor.constraint(equalTo: containerView.topAnchor),
//            cellImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            cellImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            cellImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//
//
////            cellView.topAnchor.constraint(equalTo: containerView.topAnchor),
////            cellView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
////            cellView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
////            cellView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
////
//
//        ])
//    }
//
//
//
//}





//
//  SportCollectionViewCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    static let reuseID = "SportCollectionViewCell"
    
    let cellView       = DefaultView(viewColor: .lightGray, viewRaduis: 15)
    let cellImage      = DefaultImageView(frame: .zero)
    let cellTitle      = TitleLabel(textAlignment: .center, fontSize: 30, fontColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .green
        configureCellView()
        configureCellImage()
        configureCellTitle()

    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    
    
    func configureCell(with sport: Sports){
        cellTitle.text = sport.strSport
        cellImage.downloadImg(from: sport.strSportThumb ?? "")
    }
    
    private func configureCellView(){
        
        contentView.addSubview(cellView)
            
        cellView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
        
        NSLayoutConstraint.activate([
        
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 25),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -35),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -40),

        ])
        
    }
    
    private func configureCellTitle(){
        contentView.addSubview(cellTitle)
        cellTitle.text = "eslam"
        cellTitle.numberOfLines = 2
        cellTitle.textColor = .black
        NSLayoutConstraint.activate([
            cellTitle.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
//            cellTitle.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            cellTitle.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            cellTitle.trailingAnchor.constraint(equalTo: cellView.centerXAnchor),
//            cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30)
        ])
    }
    
    private func configureCellImage(){
        contentView.addSubview(cellImage)
        cellImage.layer.cornerRadius = 80
//        cellImage.alpha = 0.8
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImage.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    
}
