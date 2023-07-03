//
//  ServicesManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation
import Alamofire
import AlamofireImage

class ServicesManager{
    static let shared = ServicesManager()
    let url = "https://api.spacexdata.com/v3/launches/past"
    private init() {}
    
    func fetchListMissions(completation: @escaping([MissionModel]?)->Void){
        AF.request(url).responseDecodable(of: [MissionModel].self){ response in
            switch response.result{
                case .success(let missions):
                    completation(missions)
                    case .failure(let _):
                    completation([])
            }
        }
    }
}
