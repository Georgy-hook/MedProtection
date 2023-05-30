//
//  CurrentPatientFactory.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 30.05.2023.
//

import Foundation
import RealmSwift
class PatientsFactory {
    func createPatient(patients: patients) -> Patient {
        let patient = Patient()
        patient.id = patients.id
        patient.firstName = patients.name
        patient.lastName = patients.surname
        patient.patronymic = patients.patronymic
        patient.personImage = patients.personImage
        patient.age = patients.age
        patient.analysis.append(objectsIn: patients.analysis.map(createAnalys))
        
        return patient
    }

    func createAnalys(analys: analys) -> Analys {
        let analysis = Analys()
        analysis.id = analys.id
        analysis.name = analys.name
        analysis.urlImage = analys.image

        return analysis
    }
}
