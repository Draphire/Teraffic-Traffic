//
//  TrafficSummaryView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 6/12/20.
//

import Foundation
import SwiftUI
import UIKit

// SwiftUI View Wrapper for UIKit ScrollView
struct ScrollUIView: View {
    // Can be using state binding or environment object
    @Binding var selectedAnnotation: Camera?

    @State var isActive = false
    
//    @EnvironmentObject var cameraSelected: TrafficCameraSelectedObservableObject
    
    
    
    var body: some View {
        
//        if cameraSelected.cameraSelected {
//            TrafficCameraDetailView(selectedAnnotation: self.$cameraSelected.camera)
//        }else{
        
            NavigationView{
                ZStack{
                    ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation, listType: "traffic", isActive:$isActive)
                    .background(
                    NavigationLink(destination:
//                                    TrafficCameraDetailView(selectedAnnotation: self.$selectedAnnotation),
                                    ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation, listType: "details", isActive:$isActive),
                                   isActive: $isActive
//                                    TrafficCameraDetailView(selectedAnnotation: self.$cameraSelected.camera),
//                                   isActive: self.$cameraSelected.cameraSelected
                    ){
                    Text("Page  Link")
                }
                
        //
            )
            }
                .navigationTitle("Daily Traffic")
            }
       
    }
//    }
    
}

// SwiftUI View Wrapper for UIKit ScrollView
struct FavouriteScrollUIView: View {
    // Can be using state binding or environment object
    @Binding var selectedAnnotation: Camera?

    @State var isActive = false
    
//    @EnvironmentObject var cameraSelected: TrafficCameraSelectedObservableObject
    
    
    
    var body: some View {
        
//        if cameraSelected.cameraSelected {
//            TrafficCameraDetailView(selectedAnnotation: self.$cameraSelected.camera)
//        }else{
        
            NavigationView{
                ZStack{
                    ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation, listType: "favourite", isActive:$isActive)
                    .background(
                    NavigationLink(destination:
//                                    TrafficCameraDetailView(selectedAnnotation: self.$selectedAnnotation)
                                   
                                       ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation, listType: "details", isActive:$isActive),
                                   isActive: $isActive
//                                    TrafficCameraDetailView(selectedAnnotation: self.$cameraSelected.camera),
//                                   isActive: self.$cameraSelected.cameraSelected
                    ){
                    Text("Page  Link")
                }
                
        //
            )
            }
                .navigationTitle("Daily Traffic")
            }
       
    }
//    }
    
}

struct ScrollUIViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    
    @EnvironmentObject var trafficDetail: TrafficCameraDetailObservableObject
    @EnvironmentObject var cameraSelected: TrafficCameraSelectedObservableObject
    
//    @State var selectedAnnotation: Camera?
    @Binding var selectedAnnotation: Camera?
    
    var listType: String
    
    
    
@Binding var isActive : Bool
//    var width : CGFloat
//      var height : CGFloat
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, model: trafficCameras, detailModel: trafficDetail,
//                    selectedAnnotation: selectedAnnotation,
                    listType: listType)
        }
    
    func makeUIView(context: Context) -> UIScrollView {
            let control = UIScrollView()
            control.refreshControl = UIRefreshControl()
            control.refreshControl?.addTarget(context.coordinator, action:
                #selector(Coordinator.handleRefreshControl),
                                              for: .valueChanged)
        
//        var childView : UIHostingController<Content: View>
        if listType == "favourite" {
            
           let childView = UIHostingController(rootView:  TrafficFavouriteListView(selectedAnnotation: $selectedAnnotation, isActive:$isActive))

            childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-150)
            
                 control.addSubview(childView.view)
        } else if listType == "traffic"{
            let  childView = UIHostingController(rootView:  TrafficListView(selectedAnnotation: $selectedAnnotation, isActive:$isActive))
           
            childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100)

                 control.addSubview(childView.view)
        
        } else {
            let  childView = UIHostingController(rootView:  TrafficCameraDetailView(selectedAnnotation: $selectedAnnotation))
           
            childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100)

                 control.addSubview(childView.view)
        }
       
            return control
        }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
//        let childView = UIHostingController(rootView: TrafficSummaryView(selectedAnnotation: $selectedAnnotation))
//            childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                
//        uiView.addSubview(childView.view)
        //UINavigationController(rootViewController: UIHostingController(rootView: MyView()))
        
//        let childView = UINavigationController(rootViewController: UIHostingController( rootView: TrafficListView(selectedAnnotation: $selectedAnnotation)))
        
//        let childView = UIHostingController(rootView: TrafficListView(selectedAnnotation: $selectedAnnotation))
//            childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//
//        uiView.addSubview(childView.view)
        print("update scrollView")
    }
    
    
    class Coordinator: NSObject {
            var control: ScrollUIViewRepresentable
            var model :TrafficCamerasObservableObject
//        var detailModel :TrafficCameraDetailObservableObject
        var detailModel :TrafficCameraDetailObservableObject
//        @Binding var selectedAnnotation: Camera?
//        var selectedAnnotation: Binding<Camera?>
        var listType: String = "traffic"
//        @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
        init(_ control: ScrollUIViewRepresentable?, model: TrafficCamerasObservableObject,
             detailModel: TrafficCameraDetailObservableObject
//             , selectedAnnotation: Binding<Camera?>
//             , selectedAnnotation: Camera?
             , listType: String) {
//            super.init()
            self.control = control!
                self.model = model
            self.detailModel = detailModel
//            self.selectedAnnotation = selectedAnnotation
            self.listType = listType
            }
        
    @objc func handleRefreshControl(sender: UIRefreshControl) {
                sender.endRefreshing()
        //model.fetchTrafficCameras()
//                trafficCameras.fetchTrafficCameras()
//        model.fetchTrafficCameras()
        if listType == "details"{
//            detailModel.fetchCamera(cameraId: selectedAnnotation!.id)
//                trafficDetail.fetchCamera(cameraId: selectedAnnotation!.id)
        }else{
                model.fetchTrafficCameras()
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
}
