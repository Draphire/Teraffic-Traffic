//
//  TrafficGoogleMapView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 2/2/21.
//

//GoogleMapViewRepresentable()
//    .edgesIgnoringSafeArea(.top)
//    .frame(height: 300)
//PlacesList()

import SwiftUI

struct TrafficGoogleMapView: View{
    
    
    @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
    @EnvironmentObject var favouritelist:
        FavouriteListObservableObject
    @EnvironmentObject var trafficDetail: TrafficCameraDetailObservableObject
    
    @Binding var isActive : Bool
    @Binding var selectedAnnotation: Camera?
    
    var body: some View {
        NavigationView{
            ZStack{
                if let cameras =
                    trafficCameras.trafficCameras?.items[0] {
        
        GoogleMapViewRepresentable(cameraItems:cameras.cameras,
                                   annotationOnTap: { cameras in
            //                        NavigationLink( "MapSource", destination:
            //                                            TrafficCameraDetailView( camera: cameras.camera), isActive:$isActive)
                                    print("assign binding for navigation = ", cameras.id)
                                    isActive = true
                                    selectedAnnotation = cameras.camera
//                                    self.trafficDetail.setSelectedCamera(cameraSelected: cameras.camera)
                                    self.trafficDetail.setSelectedCameras(camerasSelected: cameras)
            //                        TrafficCameraDetailView( camera: title.camera)
                                    
                                })
//            .edgesIgnoringSafeArea(.top)
//            .frame(height: 300)
            .background(
                NavigationLink(destination:
                                TrafficCameraDetailView(
//                                    selectedAnnotation: self.$selectedAnnotation
//                                                        , camera: cameras.cameras[0].camera
                                ), isActive: $isActive){
                Text("Page  Link")
            }
    //
        )
//        PlacesList()
    
                }else {
                    ProgressView()
                }
            }.navigationTitle("Traffic Map")
        }
    }
    
}
