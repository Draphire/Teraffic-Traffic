//
//  Model.swift
//  Teraffic
//
//  Created by WeeLiang Ng on 27/10/20.
//

import Foundation

struct AllTrafficCameras: Decodable {
    
    let items: [Items]
    
    enum CodingKeys: String, CodingKey {
        
        case items = "items"
    }
}

struct Items: Decodable{
    let timeStamp: String?
    let camera: [Cameras]
    
    enum CodingKeys: String, CodingKey {
        case timeStamp = "timestamp"
        case camera = "cameras"
    }
}

struct Cameras: Decodable, Identifiable{
    
//struct Cameras: Codable, Identifiable, Hashable{
    let id:String
    let timeStamp:String?
    let image:String
    let imageMetaData: ImageMetaData
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "camera_id"
        case timeStamp = "timestamp"
        case image = "image"
        case imageMetaData = "image_metadata"
        case location = "location"
    }
    
}

struct ImageMetaData: Decodable {
    let height: Int
    let width: Int
    let md5: String?
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case width = "width"
        case md5 = "md5"
    }
}

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

//struct CamInfo: Decodable, Identifiable{
//    let timeStamp: String?
//    let id: String
//    let image:String
//    let location: Location
//    let name: String
//
//    enum CodingKeys: String, CodingKey{
//        case timeStamp = "TimeStamp"
//        case
//    }
//}
