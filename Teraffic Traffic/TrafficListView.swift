//
//  TrafficListView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 29/3/21.
//

import SwiftUI

struct TrafficListView: View {
    @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
//    @ObservedObject var trafficCameras: TrafficCamerasObservableObject
    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    
    @EnvironmentObject var trafficDetail: TrafficCameraDetailObservableObject
    @State private var searchQuery: String = ""
    
    @Binding var selectedAnnotation: Camera?
    
    @Binding var isActive : Bool
    
//    @EnvironmentObject var cameraSelected: TrafficCameraSelectedObservableObject
    
    var body: some View {
//        NavigationView{
//            VStack{
                if let cameras = trafficCameras.trafficCameras?.items[0] {
                    List{
                        Section(header: Text("Singapore Traffic Cameras")){
//                            Text(cameras.camera.description.description)
                        }
                        
                        Section(header: SearchBar(text: self.$searchQuery)) {
                            ForEach(cameras.cameras.filter{self.searchQuery.isEmpty ? true: $0.id.contains(searchQuery)},id: \.self) { cameras in
                                
                                Button(action: {
                                    // source of setting the selected camera from list view
//                                    self.trafficDetail.setSelectedCamera(cameraSelected: cameras.camera)
                                    self.trafficDetail.setSelectedCameras(camerasSelected: cameras)
                                    
                                    self.isActive.toggle()

                                    
//                                    self.selectedAnnotation = cameras.camera
//                                    self.cameraSelected.selectCamera(camera: cameras.camera)
                                    self.trafficDetail.setSelectedCamera(cameraSelected: cameras.camera)

                                }){
                                    TrafficCameraRowView(cameraItem: cameras, isAddedToFavouritelist: favouritelist.isAddedToFavouritelist(camera: cameras.camera)).padding(.vertical)
                                }
//                                NavigationLink(
//
//                                    destination: TrafficCameraDetailView( selectedAnnotation: $selectedAnnotation, camera: cameras.camera),
//                                    label: {
//
//                                TrafficCameraRowView(cameraItem: cameras, isAddedToFavouritelist: favouritelist.isAddedToFavouritelist(camera: cameras.camera)).padding(.vertical)
//
//                                    }
//                                )
//
//                                Text(cameraItem.image ?? "Image not available")
//                                Text( "null")
//                                NavigationLink(
//                                    destination: CountryDetailView(country: cameraItem.country),
//                                    label: {
//                                        CountryStatsRowView(cameraItem: cameraItem, isAddedToWatchlist: watchlist.isAddedToWatchlist(country: countryStat.country))
//                                            .padding(.vertical)
//
//                                    })F
                            }
                        }
                        
                    }.listStyle(InsetGroupedListStyle())
                    
                }else {
                    ProgressView()
                }
                
//            }
//            .navigationViewStyle(StackNavigationViewStyle())
//            .navigationTitle("Daily Summary")
//        }.navigationViewStyle(StackNavigationViewStyle())
//        .navigationTitle("Daily Summary")
    }
    
}

//struct ImageView: View {
//    @ObservedObject var imageLoader:ImageLoader
//    @State var image:UIImage = UIImage()
//
//    init(withURL url:String) {
//        imageLoader = ImageLoader(urlString:url)
//    }
//
//    var body: some View {
//
//            Image(uiImage: image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width:100, height:100)
//                .onReceive(imageLoader.didChange) { data in
//                self.image = UIImage(data: data) ?? UIImage()
//        }
//    }
//}

