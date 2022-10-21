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
//
//                        NavigationLink( destination:
//                                                    TrafficCameraDetailView(
//                                                        selectedAnnotation: $selectedAnnotation, camera: cameras), isActive:$isActive){
//
//                        EmptyView()
//                    })
                    .background(
                        NavigationLink(destination:
                                        TrafficCameraDetailView(
//                                            selectedAnnotation: self.$selectedAnnotation
//                                                                ,
//                                                                camera: cameras.cameras[0].camera
                                        ), isActive: $isActive){
                        Text("Page  Link")
                    }
            //
                )
//                    .frame(height: 200)
                    
                }else {
                    ProgressView()
                }
            }.navigationTitle("Traffic Map")
        }
    }
}
