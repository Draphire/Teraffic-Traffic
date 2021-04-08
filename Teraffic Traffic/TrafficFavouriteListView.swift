//
//  FavouriteListView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 18/12/20.
//

import SwiftUI

struct TrafficFavouriteListView : View{
    //modified independent Favourites List View
    @EnvironmentObject var favouriteList: FavouriteListObservableObject
    @EnvironmentObject var trafficCameras : TrafficCamerasObservableObject
    
    @EnvironmentObject var trafficDetail: TrafficCameraDetailObservableObject
    
    @State var selectedCamera: Camera?
    
    @Binding var selectedAnnotation: Camera?
    
    @Binding var isActive : Bool
    
    private func camerasFavourited(with camera: Camera) -> Cameras? {
        guard let favouriteList = trafficCameras.trafficCameras?.items[0].cameras else {
            return nil
        }
        return favouriteList.first { camera.id == $0.id}
    }
    
    var body: some View {
//        NavigationView{
            List {
                ForEach(favouriteList.favouritelist){
                    camerasInList in
//                    AsyncImage(
//                        url : URL(string: cameras.image)!,
//                        placeholder: { Text("Loading ...")},
//                        image: { Image(uiImage: $0).resizable()}
//                    )
//                    .frame(idealHeight: UIScreen.main.bounds.width / 2 * 1)
                    if let cameras = camerasFavourited(with: camerasInList){
                        
                        
                        Button(action: {
                            self.isActive.toggle()
                            self.selectedAnnotation = cameras.camera
                            self.trafficDetail.setSelectedCamera(cameraSelected: cameras.camera)
//                            self.cameraSelected.selectCamera(camera: cameras.camera)
                        }){
                                TrafficCameraRowView(cameraItem: cameras, isAddedToFavouritelist: favouriteList.isAddedToFavouritelist(camera: cameras.camera)).padding(.vertical)
                        }
//                        NavigationLink( destination: TrafficCameraDetailView( selectedAnnotation: $selectedAnnotation
////                                                                              , camera: cameras.camera
//                        ),
//
//                                        label:{
//                                            TrafficCameraRowView(cameraItem: cameras, isAddedToFavouritelist: favouriteList.isAddedToFavouritelist(camera: cameras.camera)).padding(.vertical)
//                                        })
                        
                        
                    } else {
                        Text(camerasInList.id)
                    }
                    
                }
                .onDelete(perform: delete(at:))
                .onMove(perform: move(indices:newOffset:))
            }
            .navigationBarItems(trailing: EditButton())
            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("FavouriteCameras")
//        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach{(index) in
        let camera = favouriteList.favouritelist[index]
        favouriteList.toggle(camera: camera)
        }
        }
    
    func move(indices: IndexSet, newOffset: Int) {
        favouriteList.move(indices: indices, newOffset: newOffset)
    }
}

//struct FavouritelistView_Previews: PreviewProvider {
//    static var previews: some View {
////        FavouriteListView()
//    }
//}
