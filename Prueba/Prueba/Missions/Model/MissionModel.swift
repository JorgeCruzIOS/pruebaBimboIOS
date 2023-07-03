//
//  MissionModel.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation
import RealmSwift

class MissionModel: RealCodable{
    @objc dynamic var flight_number: Int = 0
    @objc dynamic var mission_name: String?
    @objc dynamic var details: String?
    @objc dynamic var launch_site: LaunchSite?
    @objc dynamic var launch_date_local: String?
    @objc dynamic var links: Links?
    @objc dynamic var rocket: Rocket?
}

class LaunchSite: RealCodable {
    @objc dynamic var site_id: String?
    @objc dynamic var site_name: String?
}

class Rocket:  RealCodable {
    @objc dynamic var rocket_id: String?
    @objc dynamic var rocket_name: String?
    @objc dynamic var rocket_type: String?
}

class Links:  RealCodable {
    @objc dynamic var mission_patch: String?
    @objc dynamic var article_link: String?
    @objc dynamic var wikipedia: String?
    @objc dynamic var video_link: String?
    @objc dynamic var reddit_launch: String?
    @objc dynamic var youtube_id: String?
    @objc dynamic var flickr_images: [String]?
    @objc dynamic var flickrArray: String?
    
    override static func ignoredProperties() -> [String] {
        return ["flickr_images"]
    }
}
