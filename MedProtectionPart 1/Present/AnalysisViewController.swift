//
//  AnalysisViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 13.02.2023.
//

import UIKit
import RealmSwift
class AnalysisViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var nameCurrentPatient: UILabel!
    @IBOutlet weak var surnameCurrentPatient: UILabel!
    @IBOutlet weak var patronymicCurrentPatient: UILabel!
    @IBOutlet weak var ageCurrentPatient: UILabel!
    
    @IBOutlet weak var imageCurrentPatient: UIImageView!
    
   
    // Первоначальная инициализация структуры
    var person:CurrentPatient = CurrentPatient(name: "", surname: "", patronymic: "", age: 1, urlImage: "")
    
    let realm = try!Realm(configuration: .init(schemaVersion: 3))
    var analysRealm:List<Analys>?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analysRealm!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnalysCell
        cell.analysName.text = analysRealm![indexPath.row].name
        return cell
    }

    @IBOutlet weak var analysTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        analysTableView.dataSource = self
        analysTableView.delegate = self
        person.fillPatientInformationWith(Labelname: &nameCurrentPatient,
                                          labelSurname: &surnameCurrentPatient,
                                          labelPatronomyc: &patronymicCurrentPatient,
                                          labelAge: &ageCurrentPatient,
                                            imagePatient: &imageCurrentPatient) // Заполнение карточки из предыдущего view
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath)
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "CryptoController") as! CryptoController
        nextViewController.urlString = analysRealm![indexPath.row].urlImage
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
}
