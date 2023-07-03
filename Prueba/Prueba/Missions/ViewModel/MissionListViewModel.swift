//
//  MissionViewModel.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation
import UIKit

class MissionListViewModel{
    var missions = [MissionModel]()
}
//Consumos de informacion
extension MissionListViewModel{
    func loadMissions(_ succesfull: @escaping ([MissionModel]?)-> Void){
        DatabaseManager.shared.fetchOnDatabase(MissionModel.self, completation: { response in
            if response.count == 0{
                ServicesManager.shared.fetchListMissions { e in
                    let modelFixed = e?.map({ emuted in
                        emuted.links?.flickrArray = emuted.links?.flickr_images?.joined(separator: ",")
                        return emuted
                    })
                    succesfull(modelFixed)
                    modelFixed?.forEach({ a in
                        DatabaseManager.shared.saveOnDatabase(response: a)
                    })
                }
            }else{
                succesfull(response)
            }
        })
    }
}

//Funciones de vista
extension MissionListViewModel{
    
    func numberOfRowsInSection()->Int{
        return self.missions.count
    }
    
    func missionAtRow(_ index: Int)->MissionViewModel{
        return MissionViewModel(mission: self.missions[index])
    }
}
