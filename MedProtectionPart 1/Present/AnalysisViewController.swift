//
//  AnalysisViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 13.02.2023.
//

import UIKit
import RealmSwift
class AnalysisViewController: UIViewController{
    //MARK: - Outlets
    @IBOutlet weak var nameCurrentPatient: UILabel!
    @IBOutlet weak var surnameCurrentPatient: UILabel!
    @IBOutlet weak var patronymicCurrentPatient: UILabel!
    @IBOutlet weak var ageCurrentPatient: UILabel!
    @IBOutlet weak var imageCurrentPatient: UIImageView!
    @IBOutlet weak var analysTableView: UITableView!
    
    // Первоначальная инициализация структуры
    var person:CurrentPatient = CurrentPatient(name: "", surname: "", patronymic: "", age: 1, urlImage: "")
    
    let realm = RealmService.shared.realm
    var analysRealm:List<Analys>?
    
    func fillPatientInformationWith(patient: CurrentPatient){
         nameCurrentPatient.text = "Имя: \(patient.name)"
         surnameCurrentPatient.text = "Фамилия: \(patient.surname)"
         patronymicCurrentPatient.text = "Отчество: \(patient.patronymic)"
         ageCurrentPatient.text = "Возраст: \(patient.age)"
        if let url = URL(string: patient.urlImage) {
               imageCurrentPatient.downloaded(from: url)
           } else {
               ErrorAlertService.showAlert(on: self, with: .networkError)
           }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analysTableView.dataSource = self
        analysTableView.delegate = self
        fillPatientInformationWith(patient: person)
    }
}

//MARK: - TableView DataSource
extension AnalysisViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analysRealm?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnalysCell
        cell.analysName.text = analysRealm![indexPath.row].name
        return cell
    }
}

//MARK: - TableView Delegate
extension AnalysisViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "CryptoController") as! CryptoController
        nextViewController.urlString = analysRealm![indexPath.row].urlImage
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
