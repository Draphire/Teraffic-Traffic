//
//  TrafficSummaryView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 6/12/20.
//

import SwiftUI

struct TrafficSummaryView: View {
    @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
//    @ObservedObject var trafficCameras: TrafficCamerasObservableObject
    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    
    @State private var searchQuery: String = ""
    
    @Binding var selectedAnnotation: Camera?
    var body: some View {
        NavigationView{
            ZStack{
                if let cameras = trafficCameras.trafficCameras?.items[0] {
                    List{
                        Section(header: Text("Singapore Traffic Cameras")){
//                            Text(cameras.camera.description.description)
                        }
                        
                        Section(header: SearchBar(text: self.$searchQuery)) {
                            ForEach(cameras.cameras.filter{self.searchQuery.isEmpty ? true: $0.id.contains(searchQuery)},id: \.self) { cameras in
                                
                                NavigationLink(
                                
                                    destination: TrafficCameraDetailView(
                                        
//                                        selectedAnnotation: $selectedAnnotation
//                                                                          , camera: cameras.camera
                                    ),
                                    label: {
//                                AsyncImage(
//                                    url : URL(string: cameraItem.camera.image)!,
//                                    placeholder: { Text("Loading ...")},
//                                    image: { Image(uiImage: $0).resizable()}
//                                )
//                                .frame(idealHeight: UIScreen.main.bounds.width / 2 * 1)
                                
                                TrafficCameraRowView(cameraItem: cameras, isAddedToFavouritelist: favouritelist.isAddedToFavouritelist(camera: cameras.camera)).padding(.vertical)
                                
                                    })
                                
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
                }            }
            .navigationTitle("Daily Summary")
        }
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
