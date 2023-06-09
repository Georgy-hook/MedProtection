//
//  RealmInit.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 11.02.2023.
//

import RealmSwift
import UIKit
class Analys:Object{
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var urlImage: String
}
class Patient:Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var patronymic: String
    @Persisted var personImage: String
    @Persisted var age: Int
    @Persisted var analysis:List<Analys>
}

class RealmService {
    
    static let shared = RealmService()
    
    var realm: Realm!
    
    private init() {
        do {
            let config = Realm.Configuration(schemaVersion: 4)
            realm = try Realm(configuration: config)
        }  catch let error as NSError {
            print("Failed to initialise Realm: \(error.localizedDescription)")
        }
    }
    
    func fetchPatients() -> Results<Patient> {
        return realm.objects(Patient.self)
    }
    
    func savePatient(_ patient: Patient) {
        do {
            try realm.write {
                realm.add(patient, update: .modified)
            }
        } catch let error as NSError {
            print("Failed to save patient: \(error.localizedDescription)")
        }
    }
    
    func getPatient(at index: Int) -> Patient? {
        let patients = fetchPatients()
        guard patients.indices.contains(index) else {
            return nil
        }
        return patients[index]
    }

    func clearDatabase() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error clearing database: \(error)")
        }
    }
    
    func filterPatients(with searchText: String) -> Results<Patient> {
        return fetchPatients().filter("firstName CONTAINS[c] '\(searchText)' OR lastName CONTAINS[c] '\(searchText)' OR patronymic CONTAINS[c] '\(searchText)'")
    }
}
