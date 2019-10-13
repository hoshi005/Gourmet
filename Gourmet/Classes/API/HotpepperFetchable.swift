//
//  HotpepperFetchable.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/12.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

protocol HotpepperFetchable {
    func fetchGourmet(coordinate: CLLocationCoordinate2D) -> AnyPublisher<HotPepperResponse, HotpepperError>
    func fetchShop(query: String) -> AnyPublisher<HotPepperResponse, HotpepperError>
}
