///Users/weeliang/Dev/Covid19StatsWidgetKit/Part3-Completed/Shared
//  TrafficCamerasObservableObject.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 3/12/20.
//

import SwiftUI

class TrafficCamerasObservableObject: NSObject, ObservableObject {
    
    @Published var trafficCameras: AllTrafficCameras?
    @Published var isLoading = false
    @Published var error: Error?
    
    let service: DataMallRepositoryService
    
    init(service: DataMallRepositoryService =
            DataMallAPIService.shared){
        self.service = service
    }
    
    func fetchTrafficCameras(){
        isLoading = true
        error = nil
        service.getAllTrafficCameras { [weak self]
            (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let trafficCameras):
                self.trafficCameras = trafficCameras
            case .failure(let error):
                self.error = error
            }
            
        }
    }
    
}

