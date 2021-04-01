//
//  TrafficCameraSelectedObservableObject.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 1/4/21.
//

import SwiftUI


class TrafficCameraSelectedObservableObject: ObservableObject {
     var cameraSelected: Bool
    @Published var camera: Camera?
    
    /* Seems Like you missed the 'self' (send(self)) */
//        var cameras: Bool = false { willSet { objectWillChange.send(self) }
    
//    init(cameraSelected: Bool, camera: Camera) {
//           self.cameraSelected = cameraSelected
//           self.camera = camera
//       }
    
    init() {
                   cameraSelected = false
                   camera = nil
    }
    
    func selectCamera(camera: Camera) {
        cameraSelected = true
        self.camera = camera
        print("selecting camera")
      }
    func isSelected() -> Bool {
        return self.cameraSelected
        
      }
}
