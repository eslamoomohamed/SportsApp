//
//  TeamDetailsVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 28/02/2022.
//

import UIKit

class TeamDetailsVC: UIViewController {
    
    var team:Teams?
    let scrollView          = UIScrollView()
    let containerView       = DefaultView(viewColor: .white, viewRaduis: 0)
    let returnBtn           = ImageButton(typeOfBtn: .returnBtn)
    let headerImage         = DefaultImageView(frame: .zero)
    let teamImage           = DefaultImageView(frame: .zero)
    let baseInfoLabel       = TitleLabel(textAlignment: .left, fontSize: 20, fontColor: .black)
    let infoView            = DefaultView(viewColor: .white, viewRaduis: 15)
    let teamName            = TitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let teamName2           = TitleLabel(textAlignment: .left, fontSize: 16, fontColor: .black)
    let teamleauge          = TitleLabel(textAlignment: .left, fontSize: 14, fontColor: .black)
    var arrOfImagesName     = [String]()
    let galleryLabel        = TitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let viewForUpcomingCollection = DefaultView(viewColor: .clear, viewRaduis: 15)
    
    var upcomingEventsCollection: UICollectionView!
    var timerForPhotoGalCollectionView: Timer?
    var currentCellIndexForPhotoGalCollectionView = 0
    
    let stackViewForButtons  = UIStackView()
    let facebookBtn          = ImageButton(typeOfBtn: .facebook)
    let instagramBtn         = ImageButton(typeOfBtn: .instagram)
    let twitterBtn           = ImageButton(typeOfBtn: .twitter)
    let youtubeBtn           = ImageButton(typeOfBtn: .youtube)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        updateArrOfImagesWithData()
        configureScrollView()
        configureContainerView()
        configureHeaderImage()
        configureReturnBtn()
        configureTeamImage()
        configureBaseInfoLabel()
        configureInfoView()
        configureTeamName()
        configureTeamName2()
        configureTeamLeauge()
        configureGalleryLabel()
        configureViewForUpcomingCollection()
        configureUpcomingEventsCollection()
        startTimerForPhotoGalCollectionView()
        configureStackViewForButtons()
        configureFacebookBtn()
        //        configureFacebookBtn()
        //        configureYoutubeBtn()
        //        configureTwitterBtn()
        //        configureInstagramBtn()
        
        //        view.backgroundColor = .white
        //        guard let team = team else {
        //            return
        //        }
        //        print(team)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func updateArrOfImagesWithData(){
        guard let team = team else {
            return
        }
        
        self.arrOfImagesName.append(team.strTeamBanner ?? "")
        self.arrOfImagesName.append(team.strTeamFanart4 ?? "")
        self.arrOfImagesName.append(team.strTeamFanart3 ?? "")
        self.arrOfImagesName.append(team.strTeamFanart2 ?? "")
        self.arrOfImagesName.append(team.strTeamFanart1 ?? "")
    }
    
    private func configureReturnBtn(){
        containerView.addSubview(returnBtn)
        
        returnBtn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            returnBtn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            returnBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            returnBtn.widthAnchor.constraint(equalToConstant: 30),
            returnBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        //        scrollView.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureContainerView(){
        scrollView.addSubview(containerView)
        containerView.backgroundColor = .clear
        //        containerView.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            //            containerView.heightAnchor.constraint(equalToConstant: 1500),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
    
    
    private func configureHeaderImage(){
        containerView.addSubview(headerImage)
        guard let team = team else {
            return
        }
        headerImage.downloadImg(from: team.strTeamJersey ?? "")
        headerImage.backgroundColor = .white
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    
    private func configureTeamImage(){
        containerView.addSubview(teamImage)
        guard let team = team else {
            return
        }
        teamImage.downloadImg(from: team.strTeamBadge ?? "")
        NSLayoutConstraint.activate([
            teamImage.centerYAnchor.constraint(equalTo: headerImage.bottomAnchor),
            teamImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            //            teamImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            teamImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            teamImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func configureBaseInfoLabel(){
        containerView.addSubview(baseInfoLabel)
        baseInfoLabel.text = "Base Info"
        NSLayoutConstraint.activate([
            baseInfoLabel.topAnchor.constraint(equalTo: teamImage.bottomAnchor, constant: 5),
            baseInfoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            baseInfoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
    }
    
    
    private func configureInfoView(){
        containerView.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: baseInfoLabel.bottomAnchor, constant: 5),
            infoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            //            infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    
    
    private func configureTeamName(){
        infoView.addSubview(teamName)
        teamName.numberOfLines = 2
        guard let  team = team else {
            return
        }
        teamName.text = team.strAlternate
        NSLayoutConstraint.activate([
            teamName.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20),
            teamName.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            teamName.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
        ])
    }
    
    
    private func configureTeamName2(){
        infoView.addSubview(teamName2)
        guard let  team = team else {
            return
        }
        teamName2.text = team.strKeywords
        NSLayoutConstraint.activate([
            teamName2.topAnchor.constraint(equalTo: teamName.bottomAnchor, constant: 10),
            teamName2.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            teamName2.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
        ])
    }
    
    
    private func configureTeamLeauge(){
        infoView.addSubview(teamleauge)
        guard let  team = team else {
            return
        }
        teamleauge.text = team.strLeague
        NSLayoutConstraint.activate([
            teamleauge.topAnchor.constraint(equalTo: teamName2.bottomAnchor, constant: 10),
            teamleauge.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            teamleauge.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            teamleauge.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -15)
        ])
    }
    
    private func configureGalleryLabel(){
        containerView.addSubview(galleryLabel)
        galleryLabel.text = "Gallery"
        NSLayoutConstraint.activate([
            galleryLabel.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 15),
            galleryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            galleryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            
            
        ])
    }
    
    private func configureViewForUpcomingCollection(){
        containerView.addSubview(viewForUpcomingCollection)
        NSLayoutConstraint.activate([
            viewForUpcomingCollection.topAnchor.constraint(equalTo: galleryLabel.bottomAnchor, constant: 15),
            viewForUpcomingCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            viewForUpcomingCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            viewForUpcomingCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    
    private func configureUpcomingEventsCollection(){
        upcomingEventsCollection   = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHorizontalFlowLayout(in: self.view))
        viewForUpcomingCollection.addSubview(upcomingEventsCollection)
        upcomingEventsCollection.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: DefaultCollectionViewCell.reuseID)
        upcomingEventsCollection.isPagingEnabled = true
        upcomingEventsCollection.dataSource = self
        upcomingEventsCollection.isUserInteractionEnabled = true
        upcomingEventsCollection.showsHorizontalScrollIndicator = false
        upcomingEventsCollection.translatesAutoresizingMaskIntoConstraints = false
        upcomingEventsCollection.backgroundColor = .clear
        
        
        NSLayoutConstraint.activate([
            upcomingEventsCollection.topAnchor.constraint(equalTo: viewForUpcomingCollection.topAnchor),
            upcomingEventsCollection.leadingAnchor.constraint(equalTo: viewForUpcomingCollection.leadingAnchor),
            upcomingEventsCollection.trailingAnchor.constraint(equalTo: viewForUpcomingCollection.trailingAnchor),
            upcomingEventsCollection.bottomAnchor.constraint(equalTo: viewForUpcomingCollection.bottomAnchor)
        ])
        
    }
    
    
    private func configureStackViewForButtons(){
        containerView.addSubview(stackViewForButtons)
        stackViewForButtons.addArrangedSubview(facebookBtn)
        stackViewForButtons.addArrangedSubview(youtubeBtn)
        stackViewForButtons.addArrangedSubview(instagramBtn)
        stackViewForButtons.addArrangedSubview(twitterBtn)
        stackViewForButtons.alignment = .fill
        stackViewForButtons.distribution = .fillEqually
        stackViewForButtons.translatesAutoresizingMaskIntoConstraints = false
        facebookBtn.addTarget(self, action: #selector(openUrlWithSafari), for: .touchUpInside)
        stackViewForButtons.spacing = 5
        NSLayoutConstraint.activate([
            stackViewForButtons.topAnchor.constraint(equalTo: upcomingEventsCollection.bottomAnchor, constant: 20),
            stackViewForButtons.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackViewForButtons.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
            
            
        ])
    }
    
    @objc func openUrlWithSafari(){
        guard let team = team else {
            return
        }
        guard let url = URL(string: "https://\(team.strFacebook!)") else{
            
            return
            
        }
        presentSafariVC(with: (url))
        
    }
    
    
    private func configureFacebookBtn(){
        NSLayoutConstraint.activate([
            //            facebookBtn.topAnchor.constraint(equalTo: upcomingEventsCollection.bottomAnchor, constant: 20),
            //            facebookBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 100),
            facebookBtn.widthAnchor.constraint(equalToConstant: 40),
            facebookBtn.heightAnchor.constraint(equalToConstant: 40),
            //            facebookBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureYoutubeBtn(){
        containerView.addSubview(youtubeBtn)
        NSLayoutConstraint.activate([
            //            youtubeBtn.topAnchor.constraint(equalTo: upcomingEventsCollection.bottomAnchor, constant: 20),
            youtubeBtn.centerYAnchor.constraint(equalTo: facebookBtn.centerYAnchor),
            youtubeBtn.leadingAnchor.constraint(equalTo: facebookBtn.trailingAnchor, constant: 20),
            youtubeBtn.widthAnchor.constraint(equalToConstant: 50),
            youtubeBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func configureTwitterBtn(){
        containerView.addSubview(twitterBtn)
        NSLayoutConstraint.activate([
            //            twitterBtn.topAnchor.constraint(equalTo: upcomingEventsCollection.bottomAnchor, constant: 20),
            twitterBtn.centerYAnchor.constraint(equalTo: facebookBtn.centerYAnchor),
            twitterBtn.leadingAnchor.constraint(equalTo: youtubeBtn.trailingAnchor, constant: 20),
            twitterBtn.widthAnchor.constraint(equalToConstant: 50),
            twitterBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureInstagramBtn(){
        containerView.addSubview(instagramBtn)
        NSLayoutConstraint.activate([
            //            instagramBtn.topAnchor.constraint(equalTo: upcomingEventsCollection.bottomAnchor, constant: 20),
            instagramBtn.centerYAnchor.constraint(equalTo: facebookBtn.centerYAnchor),
            instagramBtn.leadingAnchor.constraint(equalTo: twitterBtn.trailingAnchor, constant: 20),
            instagramBtn.widthAnchor.constraint(equalToConstant: 50),
            instagramBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    
    
    
    func startTimerForPhotoGalCollectionView(){
        timerForPhotoGalCollectionView = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextIndexForUpcomingEventsCollection), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndexForUpcomingEventsCollection(){
        //        print("next Item")
        if currentCellIndexForPhotoGalCollectionView < arrOfImagesName.count - 1 {
            currentCellIndexForPhotoGalCollectionView += 1
            
            
            
        }else{
            currentCellIndexForPhotoGalCollectionView = 0
            
        }
        upcomingEventsCollection.scrollToItem(at: IndexPath(item: currentCellIndexForPhotoGalCollectionView, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    
    
    
    
    
    
    
}




extension TeamDetailsVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfImagesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionViewCell.reuseID, for: indexPath) as! DefaultCollectionViewCell
        cell.setCell(imageName: arrOfImagesName[indexPath.row])
        return cell
    }
    
}

