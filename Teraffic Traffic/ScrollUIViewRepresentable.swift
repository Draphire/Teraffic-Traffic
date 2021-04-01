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
    
    @Binding var selectedAnnotation: Camera?

    @State var isActive = false
    
    @EnvironmentObject var cameraSelected: TrafficCameraSelectedObservableObject
    
    
    
//    var annotationOnTap: (_ cameras: Cameras) -> Void
    
    var body: some View {
        
//        if cameraSelected.cameraSelected {
//            TrafficCameraDetailView(selectedAnnotation: self.$cameraSelected.camera)
//        }else{
        
            NavigationView{
                ZStack{
                ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation, isActive:$isActive).environmentObject(cameraSelected)     .background(
                    NavigationLink(destination:
                                    TrafficCameraDetailView(selectedAnnotation: self.$cameraSelected.camera),
    //                               isActive: $isActive
                                   isActive: self.$cameraSelected.cameraSelected
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
    
    @EnvironmentObject var cameraSelected: TrafficCameraSelectedObservableObject
    
//    @State var selectedAnnotation: Camera?
    @Binding var selectedAnnotation: Camera?
    
@Binding var isActive : Bool
//    var width : CGFloat
//      var height : CGFloat
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self, model: trafficCameras)
        }
    
    func makeUIView(context: Context) -> UIScrollView {
            let control = UIScrollView()
            control.refreshControl = UIRefreshControl()
            control.refreshControl?.addTarget(context.coordinator, action:
                #selector(Coordinator.handleRefreshControl),
                                              for: .valueChanged)
        let childView = UIHostingController(rootView: TrafficListView(selectedAnnotation: $selectedAnnotation, isActive:$isActive).environmentObject(cameraSelected))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            control.addSubview(childView.view)
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
    
//        @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
    init(_ control: ScrollUIViewRepresentable, model: TrafficCamerasObservableObject) {
                self.control = control
                self.model = model
            }	
    @objc func handleRefreshControl(sender: UIRefreshControl) {
                sender.endRefreshing()
//                trafficCameras.fetchTrafficCameras()
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
