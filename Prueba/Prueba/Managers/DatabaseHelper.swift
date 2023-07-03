//
//  DatabaseManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 30/06/23.
//

import Foundation
import RealmSwift

typealias RealCodable = RealmSwift.Object & Codable
class DatabaseHelper{
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            fatalError("Error inicializando Realm: \(error)")
        }
    }
    
    func saveObject<T: RealCodable>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error guardando objeto en Realm: \(error)")
        }
    }
    
    func fetchObjects<T: RealCodable>(_ type: T.Type) -> [T] {
        let objects = realm.objects(T.self)
        return objects.compactMap { $0 }
    }
    
}
