//
//  TrafficCameraDetailObservableObject.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 23/12/20.
//

import SwiftUI

//classs TrafficCameraDetailObservableObject: NSObject, ObservableObject {
class TrafficCameraDetailObservableObject: NSObject, ObservableObject {
    @Published var cameras: Cameras?
    @Published var camera: Camera?
    @Published var isLoading = false
    @Published var error: Error?
    
//    let service: DataMallRepositoryService
//
//    init(service: DataMallRepositoryService = DataMallAPIService.shared){
//        self.service = service
//    }
    
    let service: DataMallRepositoryService
    
    init(service: DataMallRepositoryService =
            DataMallAPIService.shared){
        self.service = service
    }
    
    func fetchCamera(cameraId: String) {
        isLoading = true
        error = nil
        
        service.getTrafficCameras(cameraId: cameraId) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let summary):
                self.camera = summary.camera
                self.cameras = summary
                
            case .failure(let error):
                self.error = error
            }
            
        }
    }
}
