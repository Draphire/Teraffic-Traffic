//
//  FavouriteListObservableObject.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 14/12/20.
//

import SwiftUI
import WidgetKit

class FavouriteListObservableObject: NSObject, ObservableObject {
    
    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    @Published private(set) var favouritelist: [Cameras] = [] {
        didSet{
            save(cameras: favouritelist)
            WidgetCenter.shared.reloadTimelines(ofKind: "FavouriteListCamerasWidget")
        }
    }
    
    init(userDefaults: UserDefaults = .shared){
        self.userDefaults = userDefaults
        if let favouritelist = userDefaults.object(forKey: "favouritelist") as? Data,
           let cameras = try? decoder.decode([Cameras].self, from: favouritelist){
            self.favouritelist = cameras
        }
    }
    
    func isAddedToFavouritelist(camera: Cameras) -> Bool {
        isExists(camera: camera)
    }
    
    func toggle(camera: Cameras){
        if isExists(camera: camera){
            remove(camera)
        } else {
            add(camera)
        }
    }
    
    func move(indices: IndexSet, newOffset: Int){
        var cameraList = self.favouritelist
        cameraList.move(fromOffsets: indices, toOffset: newOffset)
        self.favouritelist = cameraList
    }
    
    private func add(_ camera: Cameras){
        var cameraList = self.favouritelist
        cameraList.insert(camera, at: 0)
        self.favouritelist = cameraList
    }
    
    private func remove(_ camera: Cameras){
        var cameraList = self.favouritelist
        guard let index = cameraList.firstIndex(where: {$0.id == camera.id }) else {
            return
        }
        cameraList.remove(at: index)
        self.favouritelist = cameraList
    }
    
    private func save(cameras: [Cameras]){
//        if let encoded = try? encoder.encode(cameras) {
//            userDefaults.set(encoded, forKey: "favouritelist")
//        }
        }
    
    private func isExists(camera: Cameras) -> Bool {
        (favouritelist).first{camera.id == $0.id } != nil
    }
    
}
