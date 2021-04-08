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
    
//    @Published var selectedCamera: Camera?
    private var selectedCamera: Camera?
    
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
    
    func fetchCamera() {
        isLoading = true
        error = nil
        
        service.getTrafficCameras(cameraId: self.selectedCamera!.id) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let summary):
                self.camera = summary.camera
                self.cameras = summary
                self.selectedCamera = summary.camera
            case .failure(let error):
                self.error = error
            }
            
        }
    }
    
    func setSelectedCamera(cameraSelected: Camera){
        self.selectedCamera = cameraSelected
    }
    
    func resetSelectedCamera(){
        self.selectedCamera = nil
        self.camera = nil
        self.cameras = nil
    }
    
    func getSelectedCamera()-> Camera{
        return self.selectedCamera!
    }
}
