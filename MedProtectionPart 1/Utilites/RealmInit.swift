//
//  RealmInit.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 11.02.2023.
//

import Foundation
import RealmSwift
import UIKit
class Analys:Object{
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var urlImage: String
}
class Patient:Object {
    @Persisted var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var patronymic: String
    @Persisted var personImage: String
    @Persisted var age: Int
    @Persisted var analysis:List<Analys>
}

