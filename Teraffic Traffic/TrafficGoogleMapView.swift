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
    @Binding var isActive : Bool
    @Binding var selectedAnnotation: Camera?
    
    var body: some View {
        NavigationView{
            ZStack{
                if let cameras =
                    trafficCameras.trafficCameras?.items[0] {
        
        GoogleMapViewRepresentable(cameraItems:cameras.cameras)
            .edgesIgnoringSafeArea(.top)
            .frame(height: 300)
//        PlacesList()
    
                }else {
                    ProgressView()
                }
            }.navigationTitle("Traffic Map")
        }
    }
    
}
