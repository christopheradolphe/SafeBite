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
    @Binding var addresses: [String]
    @ObservedObject var locationManager = LocationManager()

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewMultiple

        init(parent: MapViewMultiple) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        guard let userLocation = locationManager.userLocation else { return }
        
        let region = MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        mapView.setRegion(region, animated: true)

        for address in addresses {
            geocodeAddress(address) { coordinate in
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = address
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
}


#Preview {
    ContentView()
}
