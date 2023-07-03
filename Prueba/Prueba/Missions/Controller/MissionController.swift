//
//  MissionController.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation
import UIKit

class MissionController: UIViewController{
    
    var ui : MissionView?
    var missionListVM = MissionListViewModel()
    
    override func loadView() {
        super.loadView()
        self.ui = MissionView()
        self.view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        missionListVM.loadMissions{ [weak self] (missions) in
            guard let missionsSafe = missions, let context = self else {
                return
            }
            self?.missionListVM.missions = missionsSafe
            DispatchQueue.main.async {
                self?.ui?.buildInformation(missionListVM: context.missionListVM)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
}
