//
//  TrafficCameraDetailView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 23/12/20.
//

import SwiftUI
import MapKit

struct TrafficCameraDetailView: View {

    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    
//    @StateObject var trafficDetail = TrafficCameraDetailObservableObject()
    @EnvironmentObject var trafficDetail: TrafficCameraDetailObservableObject
    
    @Binding var selectedAnnotation: Camera?
    
//    let camera: Camera
//    let cameras: Cameras
    @State var region = MKCoordinateRegion(
          center: CLLocationCoordinate2D(
            latitude:
//                trafficDetail.cameras?.location.latitude ?? <#default value#>
//                ??
                25.7617
            ,
              longitude: 80.1918
          ),
          span: MKCoordinateSpan(
              latitudeDelta: 10,
              longitudeDelta: 10
          )
      )
    
    
    var body: some View {
        ZStack{
            if
//                let cameras = trafficDetail.cameras,
               let cameraSelected =
                trafficDetail.cameras {
                
            
                List {
                    Section(header: Text("Traffic Camera Detail")){
                        Text(cameraSelected.timeStamp)
                            .font(.headline)
                        
//                        MapView
//                        MapView(cameraItems:[cameraSelected]).frame(height: 200)
//                        Map(coordinateRegion: $region).frame(height: 200)
//                        ForEach([cameraSelected]){
//
//                        }
                        GoogleMapViewRepresentable(cameraItems:[cameraSelected],
                                                   annotationOnTap: { title in
                                                                             print("Title clicked", title.camera.id)
                                                                           }).frame(height: 300)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 300)
//                        PlacesList()
                        
//                        MapViewRepresentable(cameraItems:[cameraSelected], annotationOnTap: { title in
//                            print("Title clicked", title.camera.id)
//                        }).frame(height: 300)
                    
                AsyncImage(
                    url : URL(string: cameraSelected.image)!,
                    placeholder: { Text("Loading ...")},
                    image: { Image(uiImage: $0).resizable()}
                )
                        
                    }
                }// end of list
                .listStyle(InsetGroupedListStyle())
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            favouritelist.toggle(camera: trafficDetail.getSelectedCamera())
                        }, label: {
                             Image(systemName: favouritelist.isAddedToFavouritelist(camera: trafficDetail.getSelectedCamera()) ? "star.fill" : "star")
                        })
                )
                
            }
        }.navigationTitle(trafficDetail.getSelectedCamera().id).navigationBarItems(leading: Button(action: {
            print("Dismissing sheet view...")
//            self.selectedAnnotation = nil
            trafficDetail.resetSelectedCamera()
        }) {
            Text("Done").bold()
        })
        .navigationBarItems(
            trailing:
                HStack{
                Button(action: {
                    favouritelist.toggle(camera: trafficDetail.getSelectedCamera())
                }, label: {
                     Image(systemName: favouritelist.isAddedToFavouritelist(camera: trafficDetail.getSelectedCamera()) ? "star.fill" : "star")
                })
//                    if((trafficDetail.getSelectedCamera()) != nil){

                    Button(action: {
                        print("Dismissing sheet view...")
//                        self.selectedAnnotation = nil
                        
                        trafficDetail.resetSelectedCamera()
                    }) {
                        Text("Done").bold()
                    }

//                    }
                }
            
        )
        .onAppear {
//            trafficDetail.fetchCamera(cameraId: selectedAnnotation!.id)
            trafficDetail.fetchCamera()
        }
    }


}
