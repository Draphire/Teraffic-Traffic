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
            
        
//            TrafficSummaryView(selectedAnnotation: $selectedAnnotation)
////            ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation)
//            .tabItem {
//                VStack {
//                    Image(systemName: "chart.bar")
//                    Text("Summary")
//                }
//            }
            ScrollUIView(selectedAnnotation: $selectedAnnotation)
            .tabItem {
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Summary")
                }.onTapGesture {
                    print("Summary Pressed")
                }
            }
                .tag("summary")
            
            TrafficGoogleMapView(isActive:$isActive, selectedAnnotation: $selectedAnnotation)
                .tabItem{
                    VStack{
                        Image(systemName:"star.fill")
                        Text("Google Map")
                    }
                }.tag("trafficgooglemap")
           
//            ScrollUIViewRepresentable(selectedAnnotation: $selectedAnnotation)
//            .tabItem {
//                VStack {
//                    Image(systemName: "chart.bar")
//                    Text("Summary2")
//                }
//            }
            TrafficMapView(isActive:$isActive, selectedAnnotation: $selectedAnnotation)
                .tabItem{
                    VStack{
                        Image(systemName:"star.fill")
                        Text("Apple Map")
                    }
                }.tag("trafficmap")
//            TrafficGoogleMapView(isActive:$isActive, selectedAnnotation: $selectedAnnotation)
//                .tabItem{
//                    VStack{
//                        Image(systemName:"star.fill")
//                        Text("Google Map")
//                    }
//                }.tag("trafficgooglemap")
            
            
//            FavouriteListView( selectedAnnotation: $selectedAnnotation)
            FavouriteScrollUIView( selectedAnnotation: $selectedAnnotation)
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
