//
//  FavoritesVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    let coreData   = CoreDataManager.shared
    let userDefaults = UserDefaults.standard
    let returnBtn  = ImageButton(typeOfBtn: .shareLink)
    let titleLabel = TitleLabel(textAlignment: .center, fontSize: 15, fontColor: .black)
    var sportName  = ""
    var leaguesArr = [NSManagedObject]()
    var emptyImgView = DefaultImageView(frame: .zero)
    var leagueTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        configureReturnBtn()
        configureTitleLabel()
        configureEmptyImg()
        configureLeagueTableView()
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getData()
    }
    
    
    private func configureEmptyImg(){
        view.addSubview(emptyImgView)
        emptyImgView.isHidden = true
        emptyImgView.image = UIImage(named: "emptyImage")
        NSLayoutConstraint.activate([
            emptyImgView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyImgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyImgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
        titleLabel.isHidden = true
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: returnBtn.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: returnBtn.trailingAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func getData(){
        self.leaguesArr = coreData.fetchData()
        if leaguesArr.count != 0 {
        DispatchQueue.main.async {
            self.leagueTableView.isHidden = false
            self.leagueTableView.reloadData()
            self.emptyImgView.isHidden = true
            self.titleLabel.isHidden   = false
            
            
        }
            
        }else{
            DispatchQueue.main.async {
                self.leagueTableView.isHidden = true
                self.emptyImgView.isHidden    = false
                self.titleLabel.isHidden      = true
                self.emptyImgView.alpha           = 0
                UIView.animate(withDuration: 0.3,delay: 0.2) {self.emptyImgView.alpha = 1}
            }


        }
    }
    

    
    private func configureLeagueTableView(){
        leagueTableView = UITableView(frame: .zero, style: .plain)
        leagueTableView.register(LeagueCell.self, forCellReuseIdentifier: LeagueCell.reuseID)
        view.addSubview(leagueTableView)
        leagueTableView.backgroundColor = .white
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



extension FavoritesVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.reuseID, for: indexPath) as! LeagueCell
        
        cell.setCellWithCoreData(with: leaguesArr[indexPath.row] as! LeaugesEntity)
        
        return cell
    }
    
    
}


extension FavoritesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.size.height / 5
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, completionHandler in
            
            self.presentAlert(title: "Remove From Favorite", message: "Are you sure you want to remove leauge", style: .alert) { action in
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                self.coreData.persistentContainer.viewContext.delete(self.leaguesArr[indexPath.row])
                self.userDefaults.set(false, forKey: self.leaguesArr[indexPath.row].value(forKey: "idLeague") as! String)
                self.leaguesArr.remove(at: indexPath.row)
                self.coreData.saveContext()
                self.getData()
                tableView.endUpdates()
                FavoritesVC.showToast(controller: self, message: "Leauge deleted succesful", seconds: 1.0)
            }
            

            
            
            
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguesDetailsVC = LeaguesDetailsVC()
        print(leaguesArr[indexPath.row])
        
        self.navigationController?.pushViewController(leaguesDetailsVC, animated: true)
    }
}
