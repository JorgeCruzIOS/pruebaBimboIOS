//
//  MissionDetailView.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 30/06/23.
//

import UIKit
import youtube_ios_player_helper

class MissionDetailView: UIView {
    let missionVM : MissionViewModel
    private let playerVars = ["controls" : 0,
                          "playsinline" : 0,
                          "autohide" : 0,
                          "showinfo" : 0,
                          "modestbranding" : 0]
    private lazy var contentViewScroll: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private lazy var playerView: YTPlayerView = {
        let view = YTPlayerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var informationTitle : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Mission information"
        label.textColor = .white.withAlphaComponent(0.95)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.85)
        return label
    }()
    private var placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.85)
        return label
    }()
    
    private var detailTitle : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Details"
        label.textColor = .white.withAlphaComponent(0.95)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var detailLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var resourcesContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    lazy private var imageTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Mission images"
        label.textColor = .white.withAlphaComponent(0.95)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy private var imageContainer: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.collectionViewLayout = layout
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MissionImgCell.self, forCellWithReuseIdentifier: MissionImgCell.identifier)
        return collection
    }()
    private var linksTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "More information"
        label.textColor = .white.withAlphaComponent(0.95)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(missionVM: MissionViewModel) {
        self.missionVM = missionVM
        super.init(frame: CGRect.zero)
        buildUI()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func buildUI(){
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        addSubview(contentViewScroll)
        contentViewScroll.addSubview(playerView)
        contentViewScroll.addSubview(informationTitle)
        contentViewScroll.addSubview(rocketNameLabel)
        contentViewScroll.addSubview(placeLabel)
        contentViewScroll.addSubview(detailTitle)
        contentViewScroll.addSubview(detailLabel)
        contentViewScroll.addSubview(resourcesContainer)
        if missionVM.flicks.count != 0{
            resourcesContainer.addArrangedSubview(imageTitle)
            resourcesContainer.addArrangedSubview(imageContainer)
        }
        resourcesContainer.addArrangedSubview(linksTitle)
        resourcesContainer.addArrangedSubview(createBoxLinks())
        playerView.load(withVideoId: missionVM.youtubeID, playerVars: playerVars)
        rocketNameLabel.text = missionVM.rocketName
        placeLabel.text = missionVM.missionDate + " at " + missionVM.missionSite
        detailLabel.text = missionVM.missionDetail
    }
    
    private func buildConstraints(){
        if missionVM.flicks.count != 0{
            imageContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
        NSLayoutConstraint.activate([
            contentViewScroll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentViewScroll.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentViewScroll.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentViewScroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            playerView.topAnchor.constraint(equalTo: contentViewScroll.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),
            playerView.centerXAnchor.constraint(equalTo: contentViewScroll.centerXAnchor),
            
            informationTitle.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            informationTitle.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 25),
            informationTitle.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -25),
            
            rocketNameLabel.topAnchor.constraint(equalTo: informationTitle.bottomAnchor, constant: 10),
            rocketNameLabel.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 25),
            rocketNameLabel.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -25),
            
            placeLabel.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor, constant: 5),
            placeLabel.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 25),
            placeLabel.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -25),
            
            detailTitle.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 20),
            detailTitle.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 25),
            detailTitle.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -25),
            
            detailLabel.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 25),
            detailLabel.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -25),
            
            resourcesContainer.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            resourcesContainer.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 25),
            resourcesContainer.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -25),
            resourcesContainer.bottomAnchor.constraint(equalTo: contentViewScroll.bottomAnchor, constant: -20)
        ])
    }
}

extension MissionDetailView{
    func createBoxLinks()->UIStackView{
        let box = UIStackView()
        box.axis = .horizontal
        box.spacing = 30
        box.distribution = .equalSpacing
        box.translatesAutoresizingMaskIntoConstraints = false
        for (inx,lin) in missionVM.links.enumerated(){
            let btn = UIButton()
            btn.tag = inx
            btn.setImage(UIImage(named: lin["icono"] ?? "icono"), for: .normal)
            btn.addTarget(self, action: #selector(self.openLink(_:)), for: .touchUpInside)
            btn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: 46),
                btn.widthAnchor.constraint(equalToConstant: 46)
            ])
            box.addArrangedSubview(btn)
        }
        return box
    }
    
    @objc func openLink(_ sender: UILabel){
        if let link = URL(string: missionVM.links[sender.tag]["link"] ?? ""), UIApplication.shared.canOpenURL(link) {
               UIApplication.shared.open(link, options: [:], completionHandler: nil)
           }
    }
}


extension MissionDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width   = resourcesContainer.frame.width * 0.8
        let height  = 150.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missionVM.flicks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collection = collectionView.dequeueReusableCell(withReuseIdentifier: MissionImgCell.identifier, for: indexPath) as? MissionImgCell{
            collection.buildData(imgUrl: missionVM.flicks[indexPath.row])
            return collection
        }
        return UICollectionViewCell()
    }
    
    
}
