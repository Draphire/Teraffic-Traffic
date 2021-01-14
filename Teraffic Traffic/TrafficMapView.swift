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
    
    var body: some View {
        NavigationView{
            ZStack{
                if let cameras =
                    trafficCameras.trafficCameras?.items[0] {
                    MapViewRepresentable(cameraItems:cameras.cameras,annotationOnTap: { title in
                        print("Title clicked", title)
                    }).frame(height: 200)
                    
                }else {
                    ProgressView()
                }
            }.navigationTitle("Traffic Map")
        }
    }
}
