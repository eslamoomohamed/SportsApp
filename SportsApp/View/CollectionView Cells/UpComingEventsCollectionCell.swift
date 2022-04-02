//
//  UpComingEventsCollectionCell.swift
//  SportsApp
//
//  Created by eslam mohamed on 28/02/2022.
//

import UIKit

class UpComingEventsCollectionCell: UICollectionViewCell {
    
    
    static let reuseID = "UpComingEventsCollectionCell"
    
    let containerView  = DefaultView(viewColor: .clear, viewRaduis: 15)
    let cellImage      = DefaultImageView(frame: .zero)
    let team1Label     = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .white)
    let team2Label     = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .white)
    let eventTime      = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .white)
    let eventDate      = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .white)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContainerView()
        configureCellImage()
        configureTeam1Label()
        configureTeam2Label()
        configureEventTime()
        configureEventDate()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configureCell(with events: Events){
        
        cellImage.downloadImg(from: events.strThumb ?? "")
        team1Label.text  = events.strHomeTeam
        team2Label.text  = events.strAwayTeam
        eventTime.text   = events.strTime
        eventDate.text   = events.dateEvent
        
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
    
    
    private func configureTeam1Label(){
        containerView.addSubview(team1Label)
        NSLayoutConstraint.activate([
            team1Label.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            team1Label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
        ])
    }

    
    private func configureTeam2Label(){
        containerView.addSubview(team2Label)
        NSLayoutConstraint.activate([
            team2Label.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            team2Label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    private func configureEventTime(){
        containerView.addSubview(eventTime)
        NSLayoutConstraint.activate([
            eventTime.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            eventTime.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25)
        ])
    }

    
    private func configureEventDate(){
        containerView.addSubview(eventDate)
        NSLayoutConstraint.activate([
//            eventTime.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            eventDate.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            eventDate.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5)
//            eventDate.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 60)
//            eventResult.leadingAnchor.constraint(equalTo: team1Label.trailingAnchor, constant: 10),
//            eventResult.trailingAnchor.constraint(equalTo: team2Label.leadingAnchor, constant: -10)
        ])
    }

    

}


