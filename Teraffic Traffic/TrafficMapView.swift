//
//  TrafficMapView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 8/1/21.
//

import SwiftUI


struct TrafficMapView: View {
    @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
    @EnvironmentObject var favouritelist:
        FavouriteListObservableObject
    @Binding var isActive : Bool
    @Binding var selectedAnnotation: Camera?
    
    var body: some View {
        NavigationView{
            ZStack{
                if let cameras =
                    trafficCameras.trafficCameras?.items[0] {
                    MapViewRepresentable(cameraItems:cameras.cameras,annotationOnTap: { cameras in
//                        NavigationLink( "MapSource", destination:
//                                            TrafficCameraDetailView( camera: cameras.camera), isActive:$isActive)
                        print("assign binding for navigation = ", cameras.id)
                        isActive = true
                        selectedAnnotation = cameras.camera
//                        TrafficCameraDetailView( camera: title.camera)
                        
                    })
//                    .background(
//                        NavigationLink( "MapSource", destination:
//                                                    TrafficCameraDetailView( camera: selectedAnnotation!), isActive:$isActive){
//
//                        EmptyView()
//                    })
//                    .frame(height: 200)
                    
                }else {
                    ProgressView()
                }
            }.navigationTitle("Traffic Map")
        }
    }
}
