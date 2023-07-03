//
//  MissionDetailViewModel.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 02/07/23.
//

import Foundation


class MissionViewModel{
    private (set) var missionName: String
    private (set) var missionDate: String = ""
    private (set) var missionSite: String
    private (set) var missionDetail : String
    private (set) var missionImageCache: URL?
    private (set) var rocketName: String
    private (set) var youtubeID: String
    private (set) var flicks : [String] = []
    lazy var links : [[String: String]] = {
        return buildLinks()
    }()
    lazy var numberOfAdditionalInformation: Int = {
        return countNumberOfAdditionalInformation()
    }()
    private let mission: MissionModel
    
    init(mission: MissionModel) {
        self.mission = mission
        self.missionName = "Mission " + (mission.mission_name ?? "N/A")
        self.missionSite = mission.launch_site?.site_name ?? ""
        if let toDate = DateHelper.convertStringToDate(dateString: mission.launch_date_local ?? "", format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ"){
            self.missionDate = DateHelper.convertDateToString(date: toDate, format: "EEEE, MMM d, yyyy")
        }
        self.missionDetail     = mission.details ?? "None information was found"
        self.missionImageCache = URL(string: mission.links?.mission_patch ?? "")
        
        self.rocketName = (mission.rocket?.rocket_name ?? "") +  " " +  (mission.rocket?.rocket_type ?? "")
        self.youtubeID = mission.links?.youtube_id ?? ""
        if !(mission.links?.flickrArray?.isEmpty ?? true){
            self.flicks = mission.links?.flickrArray?.components(separatedBy: ",") ?? []
        }
    }
    
    private func countNumberOfAdditionalInformation()->Int{
        return [mission.links?.article_link, mission.links?.wikipedia, mission.links?.video_link, mission.links?.reddit_launch].filter({ $0 != nil }).count
    }
    
    private func buildLinks()->[[String: String]]{
        var links = [[String: String]]()
        if let article_link = mission.links?.article_link{
            links.append(["icono" : "article_link", "link": article_link])
        }
        if let wikipedia = mission.links?.wikipedia{
            links.append(["icono" : "wikipedia", "link": wikipedia])
        }
        if let video_link = mission.links?.video_link{
            links.append(["icono" : "video_link", "link": video_link])
        }
        if let reddit_launch = mission.links?.reddit_launch{
            links.append(["icono" : "reddit_launch", "link": reddit_launch])
        }
        return links
    }
    
}
