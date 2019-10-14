//
//  DetailViewModel.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/14.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published var shop: Shop
    
    init(shop: Shop) {
        self.shop = shop
    }
}
