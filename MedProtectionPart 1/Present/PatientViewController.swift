//
//  PatientViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 12.02.2023.
//

import UIKit
import RealmSwift

class PatientViewController: UIViewController{
    //MARK: - Outlets
    @IBOutlet weak var PatientTable: UITableView!
    
    //MARK: - Variables
    let realm = RealmService.shared.realm
    var patientRealm = try! Realm().objects(Patient.self)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PatientTable.dataSource = self
        PatientTable.delegate = self
        
        if patientRealm.isEmpty {
            ErrorAlertService.showAlert(on: self, with: .noPatientData)
        }
    }
}

//MARK: - TableView DataSource
extension PatientViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PatientCell
        
        cell.name.text = patientRealm[indexPath.row].firstName
        cell.surname.text = patientRealm[indexPath.row].lastName
        cell.patronymic.text = patientRealm[indexPath.row].patronymic
        return cell
        
    }
}

//MARK: - TableView Delegate
extension PatientViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//Открытие следующего View и заполнение карточки в зависимости от выбранного пациента
        let cell = tableView.cellForRow(at: indexPath) as! PatientCell
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "AnalysisViewController") as! AnalysisViewController
        nextViewController.person = .init(name: cell.name.text!,
                                          surname: cell.surname.text!,
                                          patronymic: cell.patronymic.text!,
                                          age: patientRealm[indexPath.row].age,
                                          urlImage: patientRealm[indexPath.row].personImage)
        navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.analysRealm = patientRealm[indexPath.row].analysis
        
        
    }
}

//MARK: - SearchBar Delegate
extension PatientViewController:UISearchBarDelegate{
    
    //Функция поиска по ФИО
    func updatePatientsList(searchText: String) {
        guard searchText == "" else{
            patientRealm = try! Realm().objects(Patient.self).filter("firstName CONTAINS[c] '\(searchText)'||lastName CONTAINS[c] '\(searchText)'||patronymic CONTAINS[c] '\(searchText)'")
            PatientTable.reloadData()
            return
        }
        patientRealm = try! Realm().objects(Patient.self)
        PatientTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            self.updatePatientsList(searchText: searchText)
        }
    }
    
    // Скрываем клавиатуру на searchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
