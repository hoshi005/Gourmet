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
    @Binding var shop: Shop?
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        print(#function)
        
        mapView.setRegion(
            MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.03,
                    longitudeDelta: 0.03
                )
            ),
            animated: true
        )
        
        // アノテーションを追加.
        let newAnnotations = shops.map { ShopAnnotation(shop: $0) }
        mapView.addAnnotations(newAnnotations)
        
        // 対象の店を中央に.
        if let shop = shop {
            mapView.setCenter(shop.coordinate, animated: true)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var mapView: MapView
        
        init(_ mapView: MapView) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            print(#function)
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
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
    @State static var shop: Shop? = Shop.dummy

    static var previews: some View {
        MapView(userLocation: $location, shops: $shops, shop: $shop)
    }
}
