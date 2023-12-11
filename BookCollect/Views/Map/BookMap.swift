// Melissa Munoz / Eli - 991642239
//Reference: https://youtu.be/WTzBKOe7MmU?si=IdVnsKCnFjAsuPzC


import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: BookMap
    
    init(_ control: BookMap) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                    
                }//ifAnnotation
            }//annotationView
        }//views.first
        
    }//mapView
}//coordinator

struct BookMap : UIViewRepresentable{
    
    let locations: [Location]
    typealias UIViewType = MKMapView
    
    @EnvironmentObject var fireDBHelper : FireDBHelper

    @EnvironmentObject var locationHelper : LocationHelper
    
    //specify initial state to show the view
    func makeUIView(context: Context) -> MKMapView {
        
        let centerPoint : CLLocationCoordinate2D
        
        if (self.locationHelper.currentLocation != nil){
            
            centerPoint = self.locationHelper.currentLocation!.coordinate
        }else{
            centerPoint = CLLocationCoordinate2D(latitude: 43.8595, longitude: -79.2345)
        }
        
        
        let map = MKMapView()
        
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isPitchEnabled = true
        map.mapType = .standard
        
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<BookMap>) {
        updateAnnotations(from: uiView)
        
        let centerPoint : CLLocationCoordinate2D
        
        if (self.locationHelper.currentLocation != nil){
            centerPoint = self.locationHelper.currentLocation!.coordinate
        }else{
            centerPoint = CLLocationCoordinate2D(latitude: 43.8595, longitude: -79.2345)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerPoint, span: span)
        
        uiView.setRegion(region, animated: true)
    }
    
    private func updateAnnotations(from bookMap: MKMapView) {
        
        bookMap.removeAnnotations(bookMap.annotations)
        
        // Convert self.locations to annotations
        let annotations = self.locations.map { location in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            annotation.title = location.name
            return annotation
        }
        
        // Convert favourite locations to annotations
        let favouriteAnnotations = self.fireDBHelper.locationList.map { location in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            return annotation
        }
        
        // Combine the two arrays
        let allAnnotations = annotations + favouriteAnnotations
        
        // Add all annotations to the map
        bookMap.addAnnotations(allAnnotations)
    }

    
    
}
