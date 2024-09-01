//
//  MapView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-07-23.
//
import SwiftUI
import MapKit
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation? = nil
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
struct MapView: UIViewRepresentable {
    let address: String
    // Create and configure the map view
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    // Update the map view when needed
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Perform geocoding to convert address to coordinates
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle error or display default location if geocoding fails
                return
            }
            
            // Add a pin to the map for the location
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = placemark.name
            mapView.addAnnotation(annotation)
            
            // Set region to show the location on the map
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
}
struct MapViewMultiple: UIViewRepresentable {
    @Binding var restaurants: [Restaurant]
    @ObservedObject var locationManager = LocationManager()
    @State private var initialRegionSet = false
    @State private var showRecenterButton = false
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewMultiple
        init(parent: MapViewMultiple) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            if parent.initialRegionSet {
                parent.showRecenterButton = true
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true

        // Check if the user's location is already available and set the initial region
        if let userLocation = locationManager.userLocation {
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Adjust zoom level as needed
            )
            mapView.setRegion(region, animated: true)
        } else {
            // If the user's location isn't available yet, set the user tracking mode to follow
            // This ensures the map centers on the user's location when it becomes available
            mapView.userTrackingMode = .follow
        }

        // Add mapView to the containerView with constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        ])

        return containerView
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let mapView = uiView.subviews.first as? MKMapView else { return }
        guard let userLocation = locationManager.userLocation else { return }
        
        for restaurant in restaurants {
            geocodeAddress(restaurant.address) { coordinate in
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = restaurant.name
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    private func geocodeAddress(_ address: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Failed to geocode address: \(address), error: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            completion(location.coordinate)
        }
    }
    
    func recenterMap(_ mapView: MKMapView) {
        guard let userLocation = locationManager.userLocation else { return }
        let region = MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Adjusted for initial zoom
        )
        mapView.setRegion(region, animated: true)
        showRecenterButton = false
    }
}
#Preview {
    ContentView()
}
