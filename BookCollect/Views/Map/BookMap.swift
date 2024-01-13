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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? LocationAnnotation else {
            return nil
        }
        
        //this is for annotation customization
        let identifier = "LocationAnnotation"
        var annotationView: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        }
        
        // Set pin color
        annotationView.pinTintColor = annotation.pinColor
        
        return annotationView
    }

        
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
        
        // Convert locations to annotations
        let annotations = self.locations.map { location in
            return LocationAnnotation(location: location, title: location.name, subtitle: location.title, pinColor: UIColor.black)
        }
        
        // Convert favourite locations to annotations
        let favouriteAnnotations = self.fireDBHelper.locationList.compactMap { location -> LocationAnnotation? in
            
            //if it already exists...
            let favoriteCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            if !self.locations.contains(where: { $0.coordinate.latitude == favoriteCoordinate.latitude && $0.coordinate.longitude == favoriteCoordinate.longitude }) {
                return LocationAnnotation(
                    location: location.convertToLocation(), title: location.name,
                    subtitle: location.title, pinColor: UIColor.red)
            }
            return nil
        }
        
        bookMap.addAnnotations(annotations)
        
        bookMap.addAnnotations(favouriteAnnotations)
    }


    
    
}
