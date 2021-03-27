//
//  Model.swift
//  Teraffic
//
//  Created by WeeLiang Ng on 27/10/20.
//

import Foundation
import MapKit
import GoogleMaps
struct AllTrafficCameras: Decodable {
    
    let items: [Items]
    
    enum CodingKeys: String, CodingKey {
        
        case items = "items"
    }
}

struct Items: Decodable{
    let timeStamp: String?
    let cameras: [Cameras]
    
    enum CodingKeys: String, CodingKey {
        case timeStamp = "timestamp"
        case cameras = "cameras"
    }
}

struct Cameras: Decodable, Identifiable, Hashable{
    static func == (lhs: Cameras, rhs: Cameras) -> Bool {
        return lhs.id == rhs.id
    }
    
//struct Cameras: Codable, Identifiable, Hashable{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(timeStamp)
        hasher.combine(image)
//        hasher.combine(location)
    }
    
    let id:String
    let timeStamp:String
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
    
    var camera: Camera {
        return Camera(id: id , timeStamp: timeStamp, image: image )
//        return Camera(id: <#T##String#>, timeStamp: <#T##String#>, image: <#T##String#>, location: <#T##String#>)
    }
    
    var cameraCheckPoint: Checkpoint {
        return Checkpoint(title: id, image:image,coordinate:  CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude ), cameras: self)
//        return Camera(id: <#T##String#>, timeStamp: <#T##String#>, image: <#T##String#>, location: <#T##String#>)
    }
    
    var cameraGoogleCheckPoint: GoogleCheckpoint {
        return GoogleCheckpoint(name: id, image:image,coordinate:  CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude ), cameras: self)
//        return Camera(id: <#T##String#>, timeStamp: <#T##String#>, image: <#T##String#>, location: <#T##String#>)
    }
    
    
//    var cameraCheckPoint =  Checkpoint(title: id,
//    coordinate:  CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
    
}

//struct ccc: Codable, Identifiable, Hashable  {
//    let id: String
//    let timeStamp: String
//    let image: String
////    let location: Location
//
//    enum CodingKeys: String, CodingKey {
//        case id = "Slug"
//        case timeStamp = "Country"
//        case image = "ISO2"
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        hasher.combine(timeStamp)
//        hasher.combine(image)
//    }
//
//    var displayName: String {
//        "\(timeStamp)"
//    }
//
////    var url: URL {
////        let string = "stats://watchlist?id=\(id)&name=\(name)&iso=\(iso)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
////        return URL(string: string)!
////    }
//}

struct Camera: Codable, Identifiable, Hashable {
    let id: String
    //let name: String
    let timeStamp: String
    let image: String
//    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "camera_id"
        //case name = "name"
        case timeStamp = "timestamp"
        case image = "image"
//        case location = "location"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(timeStamp)
        hasher.combine(image)
//        hasher.combine(location)
    }
    
    // Can potentially add name derivation here
    var displayName: String {
        "\(id)"
    }
    
//    var url: URL {
//        let string = "stats://watchlist?id=\(id)&name=\(name)&iso=\(iso)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        return URL(string: string)!
//    }
    
//    var url
    
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

class Checkpoint: NSObject, MKAnnotation {
    let title: String?
//    let countryCode: String?
    let image: String?
    let coordinate: CLLocationCoordinate2D
    let cameras: Cameras

    init(title: String?, image: String?, coordinate: CLLocationCoordinate2D, cameras: Cameras) {
        self.title = title
        self.image = image
        self.cameras = cameras
//        self.countryCode = countryCode
        self.coordinate = coordinate
    }
}

class GoogleCheckpoint: GMSMarker {
//    let title: String?
//    let countryCode: String?
    let name: String?
    let image: String?
    let coordinate: CLLocationCoordinate2D
    let cameras: Cameras

    init(name: String?, image: String?, coordinate: CLLocationCoordinate2D, cameras: Cameras) {
//        self.title = title
        self.name = name
        self.image = image
        self.cameras = cameras
//        self.countryCode = countryCode
        self.coordinate = coordinate
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
