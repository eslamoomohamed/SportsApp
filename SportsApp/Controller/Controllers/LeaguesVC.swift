//
//  LeaguesVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import UIKit

class LeaguesVC: UIViewController {
    
    let network    = NetworkManager.shared
    let returnBtn  = ImageButton(typeOfBtn: .returnBtn)
    let titleLabel = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .black)
    var sportName  = ""
    var leaguesArr = [Leagues]()
    var leagueTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureReturnBtn()
        configureTitleLabel()
        configureLeagueTableView()
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    private func configureTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.text = "Leagues"
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: returnBtn.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: returnBtn.trailingAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func getData(){
        showLoadingView(animationName: "soccerLoading", backgroundColor: .lightGray)
        network.urlSessionForCountriesLeague(countryName: "England", sportName: sportName) { result in
            self.dismissLoadingView()
            switch result {
            case .success(let league):
                self.leaguesArr = league
                print("leauge arr count\(self.leaguesArr.count)")
                DispatchQueue.main.async {
                    self.leagueTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    

    
    private func configureLeagueTableView(){
        leagueTableView = UITableView(frame: .zero, style: .plain)
        leagueTableView.register(LeagueCell.self, forCellReuseIdentifier: LeagueCell.reuseID)
        view.addSubview(leagueTableView)
//        leagueTableView.backgroundColor = .green
        leagueTableView.translatesAutoresizingMaskIntoConstraints = false
        leagueTableView.dataSource = self
        leagueTableView.delegate   = self
        leagueTableView.separatorStyle = .none
        NSLayoutConstraint.activate([
            leagueTableView.topAnchor.constraint(equalTo: returnBtn.bottomAnchor, constant: 10),
            leagueTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leagueTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leagueTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}



extension LeaguesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.reuseID, for: indexPath) as! LeagueCell
        cell.setCell(with: leaguesArr[indexPath.row])
        
        return cell
    }
    
    
}


extension LeaguesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.size.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguesDetailsVC = LeaguesDetailsVC()
        print(leaguesArr[indexPath.row])
        leaguesDetailsVC.leauge = leaguesArr[indexPath.row]
        self.navigationController?.pushViewController(leaguesDetailsVC, animated: true)
    }
}
