// Melissa Munoz / Eli - 991642239



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
        
        let pin = MKPointAnnotation()
        pin.coordinate = centerPoint
        pin.title = "Current Location"
        
        uiView.addAnnotation(pin)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.locations.map(LocationAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
}
