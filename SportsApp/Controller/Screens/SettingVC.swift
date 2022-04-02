//
//  SettingVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import UIKit

class SettingVC: UIViewController {
    
    let shared = NetworkManager.shared
    var settingsTablView: UITableView!
    var arrOfViews        = [SettingInfo]()
    var arrOfCountries    = [Countries]()
    let countryPickerView = UIPickerView()





    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor(red: 188/255, green: 255/255, blue: 205/255, alpha: 1)
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)

        configureTableView()
        configureArrOfViews()
        configurePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Setting"
    }
    


    
    func configureTableView(){
                
        settingsTablView = UITableView(frame: .zero, style: .plain)
        view.addSubview(settingsTablView)
        settingsTablView.delegate = self
        settingsTablView.dataSource = self
        settingsTablView.backgroundColor = .clear
        
        settingsTablView.translatesAutoresizingMaskIntoConstraints = false
        settingsTablView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseID)
        settingsTablView.separatorStyle = .none
        settingsTablView.isScrollEnabled = false
        
        
        NSLayoutConstraint.activate([
        
            settingsTablView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTablView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTablView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTablView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
//            tablView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        ])
    
        
    }
    
    func configureArrOfViews(){
        
        let view0 = SettingInfo(imageName0: "icon-account", imageName1: "icon-chevron", title: "Your Account")
        let view1 = SettingInfo(imageName0: "icon-chat", imageName1: "icon-chevron", title: "Live Chat")
        let view2 = SettingInfo(imageName0: "icon-bulb", imageName1: "icon-chevron", title: "Dark Mode")
        let view3 = SettingInfo(imageName0: "icon-bulb", imageName1: "icon-chevron", title: "Select Country")
        arrOfViews.append(view0)
        arrOfViews.append(view1)
        arrOfViews.append(view2)
        arrOfViews.append(view3)
    }


    
    private func configurePickerView(){
        view.addSubview(countryPickerView)
//        countryPickerView.backgroundColor = .lightGray
        countryPickerView.translatesAutoresizingMaskIntoConstraints = false
        countryPickerView.dataSource = self
        countryPickerView.delegate   = self
        NSLayoutConstraint.activate([
//            countryPickerView.topAnchor.constraint(equalTo: settingsTablView.bottomAnchor, constant: 10),
            countryPickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28),
            countryPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countryPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    
    
    
    
    
    
    
    
    

}



extension SettingVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfViews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseID, for: indexPath) as! SettingCell
        settingCell.setCell(viewInfo: arrOfViews[indexPath.row])
        
        return settingCell
        
    }
}

extension SettingVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.size.height / 4
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 3:
//            print("setup Country")
            shared.urlSessionForCountries { result in
                switch result {
                case .success(let countries):
                    self.arrOfCountries = countries
                    DispatchQueue.main.async {
                        self.countryPickerView.reloadAllComponents()
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            print("setup DarkMode")

        }
    }
    
    
}


extension SettingVC: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arrOfCountries.count
    }
    
    
}

extension SettingVC: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrOfCountries[row].name_en!
    }
}

