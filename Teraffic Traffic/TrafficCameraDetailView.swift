//
//  TrafficCameraDetailView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 23/12/20.
//

import SwiftUI

struct TrafficCameraDetailView: View {

    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    @StateObject var trafficDetail = TrafficCameraDetailObservableObject()
    
    let camera: Camera
    
    var body: some View {
        ZStack{
            if
//                let cameras = trafficDetail.cameras,
               let cameraSelected =
                trafficDetail.camera {
                List {
                    Section(header: Text("Traffic Camera Detail")){
                        Text(cameraSelected.timeStamp)
                            .font(.headline)
                        
                    
                AsyncImage(
                    url : URL(string: cameraSelected.image)!,
                    placeholder: { Text("Loading ...")},
                    image: { Image(uiImage: $0).resizable()}
                )
                    }
                }
                
            }
        }.navigationTitle(camera.id)
        .onAppear {
            trafficDetail.fetchCamera(cameraId: camera.id)
        }
    }


}
