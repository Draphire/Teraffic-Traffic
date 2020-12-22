//
//  FavouriteListView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 18/12/20.
//

import SwiftUI

struct FavouriteListView : View{
    
    @EnvironmentObject var favouriteList: FavouriteListObservableObject
    @EnvironmentObject var trafficCameras : TrafficCamerasObservableObject
    @State var selectedCamera: Camera?
    
    private func cameras(with camera: Camera) -> Cameras? {
        guard let favouriteList = trafficCameras.trafficCameras?.items[0].cameras else {
            return nil
        }
        return favouriteList.first { camera.id == $0.id}
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(favouriteList.favouritelist){
                    camera in
                    AsyncImage(
                        url : URL(string: camera.image)!,
                        placeholder: { Text("Loading ...")},
                        image: { Image(uiImage: $0).resizable()}
                    )
                    .frame(idealHeight: UIScreen.main.bounds.width / 2 * 1)
                }
            }
        }
    }
    
}
