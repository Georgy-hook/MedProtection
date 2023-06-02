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
    let realmService = RealmService.shared
    var patientRealm: Results<Patient>!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        patientRealm = realmService.fetchPatients()
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
        let patient = patientRealm[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
           // Создаем новый view controller, передавая ему пациента.
        guard let nextViewController = storyboard?.instantiateViewController(identifier: "AnalysisViewController", creator: { coder in
               AnalysisViewController(coder: coder, patient: patient)
           }) else {
               return
           }

           navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
}

//MARK: - SearchBar Delegate
extension PatientViewController:UISearchBarDelegate{
    
    //Функция поиска по ФИО
    func updatePatientsList(searchText: String) {
        if searchText.isEmpty {
                   patientRealm = realmService.fetchPatients()
               } else {
                   patientRealm = realmService.filterPatients(with: searchText)
               }
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
