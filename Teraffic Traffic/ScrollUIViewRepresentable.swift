//
//  TrafficSummaryView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 6/12/20.
//

import Foundation
import SwiftUI
import UIKit

struct ScrollUIViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var trafficCameras: TrafficCamerasObservableObject
    @EnvironmentObject var favouritelist: FavouriteListObservableObject
    
//    @State var selectedAnnotation: Camera?
    @Binding var selectedAnnotation: Camera?
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
    let childView = UIHostingController(rootView: TrafficSummaryView(selectedAnnotation: $selectedAnnotation))
        childView.view.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
            
            control.addSubview(childView.view)
            return control
        }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    
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
