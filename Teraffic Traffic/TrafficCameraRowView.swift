//
//  TrafficCameraRowView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 22/12/20.
//

import SwiftUI

struct TrafficCameraRowView: View {
    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    
    let cameraItem: Cameras
    let isAddedToFavouritelist: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack {
                Text(cameraItem.id)
                    .font(.headline)
                Spacer()
                Image(systemName: isAddedToFavouritelist ? "star.fill" : "star")
                    .foregroundColor(Color(UIColor.systemBlue))
                    .onTapGesture {
                        favouritelist.toggle(camera: cameraItem.camera)
                    }
            }
            
            HStack {
                Text(cameraItem.timeStamp)
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
            .font(.caption)
            
            HStack(spacing:8) {
//                VStack(spacing: 0) {
//
//                }
                AsyncImage(
                    url : URL(string: cameraItem.camera.image)!,
                    placeholder: { Text("Loading ...")},
                    image: { Image(uiImage: $0).resizable()}
                )
                .frame(idealHeight: UIScreen.main.bounds.width / 2 * 1)
                
            }
        }
    }
}
