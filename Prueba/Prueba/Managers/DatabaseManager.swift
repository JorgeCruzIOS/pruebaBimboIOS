//
//  DatabaseManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 30/06/23.
//

import Foundation
import RealmSwift

class DatabaseManager{
    
    static let shared = DatabaseManager()
    private let database : DatabaseHelper
    
    private init() {
        self.database = DatabaseHelper()
    }
    
    func saveOnDatabase(response: RealCodable){
        database.saveObject(response)
    }
    
    func fetchOnDatabase<T:RealCodable>(_ objectType: T.Type, completation:@escaping(_ response: [T])->Void){
        completation(database.fetchObjects(T.self))
    }
}
