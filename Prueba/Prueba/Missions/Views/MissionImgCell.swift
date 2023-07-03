//
//  MissionImgCell.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 02/07/23.
//

import UIKit
import AlamofireImage

class MissionImgCell: UICollectionViewCell {
    static let identifier: String = "MissionImgCell"
    var missionImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(imgUrl: String){
        guard let imgUrl = URL(string: imgUrl) else{return}
        missionImage.af.setImage(withURL: imgUrl)
    }
    
    private func buildUI(){
        backgroundColor = .clear
        contentView.addSubview(missionImage)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
            missionImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            missionImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            missionImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            missionImage.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
