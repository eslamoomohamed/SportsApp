//
//  LeaguesDetailsVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 24/02/2022.
//

import UIKit
import Lottie

class LeaguesDetailsVC: UIViewController {
    
    var leauge: Leagues?
    
    let userDefaults        = UserDefaults.standard
    var isFavorite          = false
    let shared              = NetworkManager.shared
    let coreData            = CoreDataManager.shared
    let returnBtn           = ImageButton(typeOfBtn: .returnBtn)
    let saveBtn             = ImageButton(typeOfBtn: .addToFavorite)
    let titleLabel          = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .black)
    var allEventsArr        = [Events]()
    var specifcEventsArr    = [Events]()
    var teamsArr            = [Teams]()
    let scrollView          = UIScrollView()
    let containerView       = DefaultView(viewColor: .white, viewRaduis: 0)
    let upcomingEventsLabel = TitleLabel(textAlignment: .left, fontSize: 28, fontColor: .label)
    let latestEventsLabel   = TitleLabel(textAlignment: .left, fontSize: 28, fontColor: .label)
    let teamsLabel          = TitleLabel(textAlignment: .left, fontSize: 28, fontColor: .label)
    let viewForUpcomingCollection = DefaultView(viewColor: .clear, viewRaduis: 15)
    let viewForEventsCollection   = DefaultView(viewColor: .clear, viewRaduis: 15)
    let viewForTeamsCollection    = DefaultView(viewColor: .clear, viewRaduis: 0)
    var upcomingEventsCollection: UICollectionView!
    var timerForPhotoGalCollectionView: Timer?
    var currentCellIndexForUpComingCollectionView = 0
    
    var containerViewForAnimation: UIView!
    var animationView = AnimationView()
    
    var sportsCollection: UICollectionView!
    var teamsCollection: UICollectionView!

    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        
        configureReturnBtn()
        configureSaveBtn()
        configureTitleLabel()
        configureScrollView()
        configureContainerView()
        configureUpcomingEventsLabel()
        configureViewForUpcomingCollection()
        configureUpcomingEventsCollection()
        configureLatestEventsLabel()
        configureViewForEventsCollection()
        configureSportsCollection()
        configureTeamsLabel()
        configureViewForTeamsCollection()
        configureTeamsCollection()
        
        startTimerForUpComoingCollectionView()
        getDataOfSpecificEvents()
        getDataOfAllEvents()
        getDataOfTeams()
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        updateBtnColor()
    }
    
    private func configureReturnBtn(){
        view.addSubview(returnBtn)
        returnBtn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            returnBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            returnBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnBtn.widthAnchor.constraint(equalToConstant: 30),
            returnBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureSaveBtn(){
        view.addSubview(saveBtn)
        
        saveBtn.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            saveBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveBtn.widthAnchor.constraint(equalToConstant: 30),
            saveBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func saveBtnAction(_ sender: Any) {
        guard let leauge = leauge else {
            return
        }
        
        if (userDefaults.bool(forKey: leauge.idLeague!) == false){

            coreData.saveData(leauges: leauge)
            userDefaults.set(true, forKey: leauge.idLeague!)
            userDefaults.synchronize()
            showAnimationView()
        }
        
        else{
            userDefaults.set(false, forKey: leauge.idLeague!)
            coreData.deleteData(leauges: leauge)
            userDefaults.synchronize()
            
        }
        

        print(userDefaults.bool(forKey: leauge.idLeague!))
        updateBtnColor()

        


        
    }
    
    func updateBtnColor(){
        guard let leauge = leauge else {
            return
        }
        
        if !userDefaults.bool(forKey: leauge.idLeague!){
            self.saveBtn.setImage(UIImage(named:"favoriteIcon"), for: .normal)
            self.saveBtn.isUserInteractionEnabled = true
//            self.isFavorite = false
            

        }else{
            self.saveBtn.setImage(UIImage(named:"favoriteFilled"), for: .normal)
            self.saveBtn.isUserInteractionEnabled = false

//            self.isFavorite = true

        }
            
        

        
    }
    
    private func configureTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.text = "Leagues Details"
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: returnBtn.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: returnBtn.trailingAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

//        scrollView.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: returnBtn.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureContainerView(){
        scrollView.addSubview(containerView)
//        containerView.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 1500),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
    
    private func configureUpcomingEventsLabel(){
        containerView.addSubview(upcomingEventsLabel)
        upcomingEventsLabel.text = "Upcoming Events"
        NSLayoutConstraint.activate([
            upcomingEventsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -20),
            upcomingEventsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            

        ])
    }
    
    private func configureViewForUpcomingCollection(){
        containerView.addSubview(viewForUpcomingCollection)
        NSLayoutConstraint.activate([
            viewForUpcomingCollection.topAnchor.constraint(equalTo: upcomingEventsLabel.bottomAnchor, constant: 15),
            viewForUpcomingCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            viewForUpcomingCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            viewForUpcomingCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }

    
    private func configureUpcomingEventsCollection(){
        upcomingEventsCollection   = UICollectionView(frame: .zero, collectionViewLayout: createHorizontalFlowLayout())
        viewForUpcomingCollection.addSubview(upcomingEventsCollection)
        upcomingEventsCollection.register(UpComingEventsCollectionCell.self, forCellWithReuseIdentifier: UpComingEventsCollectionCell.reuseID)
        upcomingEventsCollection.isPagingEnabled = true
        upcomingEventsCollection.dataSource = self
        upcomingEventsCollection.isUserInteractionEnabled = true
        upcomingEventsCollection.showsHorizontalScrollIndicator = false
        upcomingEventsCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upcomingEventsCollection.topAnchor.constraint(equalTo: viewForUpcomingCollection.topAnchor),
            upcomingEventsCollection.leadingAnchor.constraint(equalTo: viewForUpcomingCollection.leadingAnchor),
            upcomingEventsCollection.trailingAnchor.constraint(equalTo: viewForUpcomingCollection.trailingAnchor),
            upcomingEventsCollection.bottomAnchor.constraint(equalTo: viewForUpcomingCollection.bottomAnchor)
        ])

    }
    
    private func configureLatestEventsLabel(){
        containerView.addSubview(latestEventsLabel)
        latestEventsLabel.text = "Latest Events"
        NSLayoutConstraint.activate([
            latestEventsLabel.topAnchor.constraint(equalTo: upcomingEventsCollection.bottomAnchor, constant: 10),
            latestEventsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            

        ])
    }
    
    private func configureViewForEventsCollection(){
        containerView.addSubview(viewForEventsCollection)
        NSLayoutConstraint.activate([
            viewForEventsCollection.topAnchor.constraint(equalTo: latestEventsLabel.bottomAnchor, constant: 15),
            viewForEventsCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            viewForEventsCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            viewForEventsCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)

        ])
    }
    
    
    private func configureSportsCollection(){
        sportsCollection = UICollectionView(frame: .zero, collectionViewLayout: createVerticalFlowLayout())
        sportsCollection.register(EventsCollectionViewCell.self, forCellWithReuseIdentifier: EventsCollectionViewCell.reuseID)
        viewForEventsCollection.addSubview(sportsCollection)
//        sportsCollection.backgroundColor = .yellow
        sportsCollection.dataSource = self
//        sportsCollection.delegate   = self
        sportsCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sportsCollection.topAnchor.constraint(equalTo: viewForEventsCollection.topAnchor),
            sportsCollection.leadingAnchor.constraint(equalTo: viewForEventsCollection.leadingAnchor),
            sportsCollection.trailingAnchor.constraint(equalTo: viewForEventsCollection.trailingAnchor),
            sportsCollection.bottomAnchor.constraint(equalTo: viewForEventsCollection.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTeamsLabel(){
        containerView.addSubview(teamsLabel)
        teamsLabel.text = "Teams"
        NSLayoutConstraint.activate([
            teamsLabel.topAnchor.constraint(equalTo: viewForEventsCollection.bottomAnchor, constant: 10),
            teamsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            

        ])
    }
    
    private func configureViewForTeamsCollection(){
        containerView.addSubview(viewForTeamsCollection)
        NSLayoutConstraint.activate([
            viewForTeamsCollection.topAnchor.constraint(equalTo: teamsLabel.bottomAnchor, constant: 15),
            viewForTeamsCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewForTeamsCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            viewForTeamsCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            viewForTeamsCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func configureTeamsCollection(){
        teamsCollection = UICollectionView(frame: .zero, collectionViewLayout: createHorizontalFlow())
        teamsCollection.backgroundColor = .clear
        viewForTeamsCollection.addSubview(teamsCollection)
        teamsCollection.register(TeamCollectionCell.self, forCellWithReuseIdentifier: TeamCollectionCell.reuseID)
        teamsCollection.delegate   = self
        teamsCollection.dataSource = self
        teamsCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamsCollection.topAnchor.constraint(equalTo: viewForTeamsCollection.topAnchor),
            teamsCollection.leadingAnchor.constraint(equalTo: viewForTeamsCollection.leadingAnchor),
            teamsCollection.trailingAnchor.constraint(equalTo: viewForTeamsCollection.trailingAnchor),
            teamsCollection.bottomAnchor.constraint(equalTo: viewForTeamsCollection.bottomAnchor),
        ])
    }

    
    
    
    
    
    func startTimerForUpComoingCollectionView(){
        timerForPhotoGalCollectionView = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextIndexForUpcomingEventsCollection), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndexForUpcomingEventsCollection(){
//        print("next Item")
        if self.specifcEventsArr.count > 0{
        if currentCellIndexForUpComingCollectionView < specifcEventsArr.count - 1 {
            currentCellIndexForUpComingCollectionView += 1
            
            

        }else{
            currentCellIndexForUpComingCollectionView = 0

        }
        upcomingEventsCollection.scrollToItem(at: IndexPath(item: currentCellIndexForUpComingCollectionView, section: 0), at: .centeredHorizontally, animated: true)
        }}
    
    
    private func getDataOfAllEvents(){
        showLoadingView(animationName: "soccerLoading", backgroundColor: .lightGray)
        shared.urlSessionForAllEvents { result in
            switch result {
            case .success(let events):
                print(events.count)
                self.allEventsArr = events
//                print(self.allEventsArr)
                let filterdArr = self.allEventsArr.filter { $0.strStatus!.starts(with: "Not") }
                print("filterdArr\(filterdArr)")
                
                DispatchQueue.main.async {
                    self.sportsCollection.reloadData()

                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func getDataOfSpecificEvents(){
        guard let leauge = leauge else {
            return
        }
        shared.urlSessionForSpecificEvents(leagueID: leauge.idLeague!, roundNumber: "28") { result in
            switch result {
            case .success(let events):
                print(events.count)
                self.specifcEventsArr = events
                DispatchQueue.main.async {
                    self.upcomingEventsCollection.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getDataOfTeams(){
        guard let leauge = leauge else {
            return
        }
        let leaugeName = leauge.strLeague!.replacingOccurrences(of: " ", with: "%20")
    
        shared.urlSessionForAllTeamsInALeague(leauge:leaugeName , Country: "England") { result in
            self.dismissLoadingView()
            switch result {
            case .success(let teams):
//                print("teams.count\(teams)")
                self.teamsArr = teams
                DispatchQueue.main.async {
                    self.teamsCollection.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func showAnimationView(){
        
//        containerViewForAnimation = UIView(frame: view.bounds)
//        view.addSubview(containerViewForAnimation)
        
//        containerViewForAnimation.backgroundColor = .clear
//        containerViewForAnimation.alpha           = 0
        
//
//        UIView.animate(withDuration: 0.25) {self.containerViewForAnimation.alpha = 1}
//
//        containerViewForAnimation.addSubview(animationView)
//        animationView.play()
//        animationView.loopMode = .loop
////        animationView.backgroundColor = .yellow
//        animationView.animation = Animation.named("addtofavorite")
//        animationView.play()
//
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//
//            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
////            animationView.widthAnchor.constraint(equalToConstant: 50),
////            animationView.heightAnchor.constraint(equalToConstant: 50)
//        ])
    
        
        UIView.animate(withDuration: 1, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
            self.showLoadingView(animationName: "addtofavorite", backgroundColor: .clear)

        }) { res in
            self.dismissLoadingView()
            self.updateBtnColor()
        }
        
    }
    
    func dismissAnimationView(){
        DispatchQueue.main.async {
            self.containerViewForAnimation.removeFromSuperview()
            self.containerViewForAnimation = nil
        }
    }



}


extension LeaguesDetailsVC: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case upcomingEventsCollection:
            return specifcEventsArr.count
        case sportsCollection :
            return allEventsArr.count
        default:
            return teamsArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upcomingEventsCollection :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpComingEventsCollectionCell.reuseID, for: indexPath) as! UpComingEventsCollectionCell
            cell.configureCell(with: specifcEventsArr[indexPath.row])
            
            return cell
            
        case sportsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.reuseID, for: indexPath) as! EventsCollectionViewCell
            cell.configureCell(with: allEventsArr[indexPath.row])
            
            return cell


        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionCell.reuseID, for: indexPath) as! TeamCollectionCell
            cell.setCell(team: teamsArr[indexPath.row])
            return cell

        }
        
    }
    
    
    
}


extension LeaguesDetailsVC: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case upcomingEventsCollection:
            print("upcomingEventsCollection")
        case sportsCollection:
            print("sportsCollection")
        default:
            let teamVC = TeamDetailsVC()
            teamVC.team = teamsArr[indexPath.row]
            print(teamsArr[indexPath.row])
            self.navigationController?.pushViewController(teamVC, animated: true)
        }

    }
    
    
    
    private func createVerticalFlowLayout()-> UICollectionViewLayout{
        let width                       = view.bounds.width - 15
//        let padding: CGFloat            = 15
//        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width //- (padding * 2) //- minimumItemSpacing
        let itemSize                    = availableWidth
        let height                      = view.bounds.height * 0.28
        let availableHeight             = height
        let itemHeight                  = availableHeight
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemHeight)
        flowLayout.scrollDirection      = .vertical
        flowLayout.minimumLineSpacing   = 0
        
        return flowLayout
    }

    private func createHorizontalFlowLayout()-> UICollectionViewLayout{
        let width                       = view.bounds.width - 10
//        let padding: CGFloat            = 15
//        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width //- (padding * 2) //- minimumItemSpacing
        let itemSize                    = availableWidth
        let height                      = view.bounds.height * 0.28
        let availableHeight             = height
        let itemHeight                  = availableHeight
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        return flowLayout
    }
    
    func createHorizontalFlow()-> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout()
        let availableWidth              = view.frame.width / 3
        flowLayout.scrollDirection      = .horizontal
        let height                      = view.bounds.height * 0.28
        let availableHeight             = height - 20
        flowLayout.itemSize             = CGSize(width: availableWidth, height: availableHeight)
        let padding: CGFloat            = 15
        flowLayout.sectionInset         = UIEdgeInsets(top: 5, left: padding, bottom: 5, right: padding)


        return flowLayout
        
    }
    
}
 
