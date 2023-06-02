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
    
    let realm = RealmService.shared.realm
    var patient: Patient

    init?(coder: NSCoder, patient: Patient) {
        self.patient = patient
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a patient.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        analysTableView.dataSource = self
        analysTableView.delegate = self
        fillPatientInformation()
    }

    func fillPatientInformation() {
        nameCurrentPatient.text = "Имя: \(patient.firstName)"
        surnameCurrentPatient.text = "Фамилия: \(patient.lastName)"
        patronymicCurrentPatient.text = "Отчество: \(patient.patronymic)"
        ageCurrentPatient.text = "Возраст: \(patient.age)"
        if let url = URL(string: patient.personImage) {
            imageCurrentPatient.downloaded(from: url)
        } else {
            ErrorAlertService.showAlert(on: self, with: .networkError)
        }
    }
}

//MARK: - TableView DataSource
extension AnalysisViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return patient.analysis.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnalysCell
          cell.analysName.text = patient.analysis[indexPath.row].name
          return cell
      }
}

//MARK: - TableView Delegate
extension AnalysisViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "CryptoController") as! CryptoController
        nextViewController.urlString = patient.analysis[indexPath.row].urlImage
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
