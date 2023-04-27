//
//  PatientViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 12.02.2023.
//

import UIKit
import RealmSwift
class PatientViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    let realm = try!Realm(configuration: .init(schemaVersion: 3))
    var patientRealm = try! Realm().objects(Patient.self)
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
    @IBOutlet weak var PatientTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PatientTable.dataSource = self
        PatientTable.delegate = self
        Connect().getData(from: Connect().url!)
        //PatientTable.keyboardDismissMode = .onDrag
    }
    //Функция поиска по ФИО
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText == "" else{
            patientRealm = try! Realm().objects(Patient.self).filter("firstName CONTAINS[c] '\(searchText)'||lastName CONTAINS[c] '\(searchText)'||patronymic CONTAINS[c] '\(searchText)'")
            PatientTable.reloadData()
            return
        }
        patientRealm = try! Realm().objects(Patient.self)
        PatientTable.reloadData()
    }

    // Скрываем клавиатуру на searchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
