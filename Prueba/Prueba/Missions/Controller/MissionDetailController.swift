//
//  MissionDetailController.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 30/06/23.
//

import UIKit

class MissionDetailController: UIViewController {

    let missionVM : MissionViewModel
    
    override func loadView() {
        super.loadView()
        self.view = MissionDetailView(missionVM: missionVM)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(missionVM.missionName)"
    }
    
    init(missionVM: MissionViewModel) {
        self.missionVM = missionVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
