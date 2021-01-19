//
//  ContentView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 2/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedCamera: Cameras?
    @State var selectedAnnotation: Camera?
    @State var selection: String = "summary"
    @State var isActive = false
    
    var body: some View {
        TabView(selection: $selection){
            
        
            TrafficSummaryView(selectedAnnotation: $selectedAnnotation)
            .tabItem {
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Summary")
                }
            }
            .tag("summary")
            TrafficMapView(isActive:$isActive, selectedAnnotation: $selectedAnnotation)
                .tabItem{
                    VStack{
                        Image(systemName:"star.fill")
                        Text("Favourite List")
                    }
                }.tag("trafficmap")
            FavouriteListView()
                .tabItem {
                    VStack{
                        Image(systemName:"star.fill")
                        Text("Favourite List")
                    }
                }
                .tag("favouritelist")
            
          
//        Text("Hello, world!")
//            .padding()
    }
//        .sheet(item: $selectedAnnotation, onDismiss: {
//        selectedAnnotation = nil
//    }, content: { (camera) in
//        NavigationView {
//            TrafficCameraDetailView(selectedAnnotation: self.$selectedAnnotation, camera: camera)
//        }
//        .background(
//            NavigationLink(destination:
//                                    TrafficCameraDetailView(selectedAnnotation: self.$selectedAnnotation, camera: selectedAnnotation!), isActive: $isActive){
//            Text("Page  Link")
//        }
//
//    )
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        ContentView( selectedAnnotation: $selectedAnnotation)
//    }
//}
