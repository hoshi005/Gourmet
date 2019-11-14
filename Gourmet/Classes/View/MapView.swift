//
//  MapView.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/11/14.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var userLocation: CLLocation
    @Binding var shops: [Shop]
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(#function)
        
        uiView.setRegion(
            MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            ),
            animated: true
        )
        
        let newAnnotations = shops.map { ShopAnnotation(shop: $0) }
        uiView.addAnnotations(newAnnotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var mapView: MapView
        
        init(_ mapView: MapView) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            print(#function)
        }
    }
}

final class ShopAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let coordinate: CLLocationCoordinate2D
    init(shop: Shop) {
        self.id = shop.id
        self.title = shop.name
        self.coordinate = shop.coordinate
    }
}

struct MapView_Previews: PreviewProvider {

    @State static var location = CLLocation(
        latitude: 35.688382,
        longitude: 139.805927
    )

    @State static var shops = [Shop.dummy]

    static var previews: some View {
        MapView(userLocation: $location, shops: $shops)
    }
}
