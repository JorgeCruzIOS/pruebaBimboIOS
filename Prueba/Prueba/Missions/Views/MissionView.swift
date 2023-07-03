//
//  MissionView.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation
import UIKit

class MissionView: UIView{
    var missionListVM: MissionListViewModel?
    lazy var listMission: UITableView = {
        let list = UITableView()
        list.translatesAutoresizingMaskIntoConstraints = false
        list.delegate = self
        list.dataSource = self
        list.backgroundColor = .clear
        list.register(MissionViewCell.self, forCellReuseIdentifier: MissionViewCell.identifier)
        return list
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.95)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Launches Past"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stay updated"
        label.textColor = .white.withAlphaComponent(0.75)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewCounter: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .white.withAlphaComponent(0.85)
        return view
    }()
    var countMessage: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.75)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var countLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.75)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Missions \ncompleated"
        return lbl
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        buildUI()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildInformation(missionListVM:MissionListViewModel){
        self.missionListVM = missionListVM
        listMission.reloadData()
        startCountAnimation(missionListVM.numberOfRowsInSection())
    }
    
    private func buildUI(){
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        addSubview(listMission)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(viewCounter)
        viewCounter.addSubview(countMessage)
        viewCounter.addSubview(countLabel)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 25),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor , constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 25),
            
            viewCounter.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            viewCounter.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 25),
            viewCounter.heightAnchor.constraint(equalToConstant: 60),
            
            countMessage.leadingAnchor.constraint(equalTo: viewCounter.leadingAnchor, constant: 10),
            countMessage.centerYAnchor.constraint(equalTo: viewCounter.centerYAnchor),
            
            countLabel.trailingAnchor.constraint(equalTo: viewCounter.trailingAnchor, constant: -10),
            countLabel.centerYAnchor.constraint(equalTo: countMessage.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: countMessage.trailingAnchor, constant: 15),
            
            listMission.topAnchor.constraint(equalTo: viewCounter.bottomAnchor, constant: 15),
            listMission.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            listMission.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            listMission.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MissionView{
    
    func startCountAnimation( _ num: Int) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = 0.5
        
        countMessage.layer.add(animation, forKey: "changeTextTransition")
        var currentValue = 0
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            currentValue += 1
            self.countMessage.text = "\(currentValue)"
            if currentValue == num {
                timer.invalidate()
            }
        }
    }
}

extension MissionView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missionListVM?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewcell = tableView.dequeueReusableCell(withIdentifier: MissionViewCell.identifier, for: indexPath) as? MissionViewCell, let missionLVM = missionListVM{
            viewcell.buildData(viewModel: missionLVM.missionAtRow(indexPath.row))
            return viewcell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = missionListVM?.missionAtRow(indexPath.row) else{
            return
        }
        NavigationManager.shared.pushViewController(MissionDetailController(missionVM: model))
    }
}
