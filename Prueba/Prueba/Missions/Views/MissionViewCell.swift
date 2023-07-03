//
//  MissionViewCell.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation
import UIKit
import AlamofireImage

class MissionViewCell: UITableViewCell{
    
    static let identifier: String = "MissionViewCell"
    var aditionalInformation: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.95)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var nextImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "arrow")
        img.tintColor = .white.withAlphaComponent(0.95)
        return img
    }()
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var imageLaunch: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.95)
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.85)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(viewModel: MissionViewModel){
        titleLabel.text = viewModel.missionName
        detailLabel.text = viewModel.missionDetail
        dateLabel.text = viewModel.missionDate + " at " + viewModel.missionSite
        if let imgurl = viewModel.missionImageCache{
            imageLaunch.af.setImage(withURL: imgurl)
        }
        aditionalInformation.text = "\(viewModel.numberOfAdditionalInformation) Articles"
    }
    
    private func buildUI(){
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(imageLaunch)
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(aditionalInformation)
        containerView.addSubview(nextImage)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            imageLaunch.widthAnchor.constraint(equalTo: imageLaunch.heightAnchor, multiplier: 1),
            imageLaunch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageLaunch.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageLaunch.heightAnchor.constraint(equalToConstant: 100),
            
            detailLabel.topAnchor.constraint(equalTo: imageLaunch.topAnchor, constant: 5),
            detailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: imageLaunch.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: detailLabel.trailingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            aditionalInformation.topAnchor.constraint(equalTo: imageLaunch.bottomAnchor, constant: 15),
            aditionalInformation.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor),
            aditionalInformation.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            nextImage.widthAnchor.constraint(equalToConstant: 20),
            nextImage.heightAnchor.constraint(equalToConstant: 20),
            nextImage.centerYAnchor.constraint(equalTo: aditionalInformation.centerYAnchor),
            nextImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
}
