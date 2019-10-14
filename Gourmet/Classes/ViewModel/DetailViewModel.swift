//
//  DetailViewModel.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/14.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var shop: Shop
    @Published var image = Image("noimage")
    
    private var requestCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    init(shop: Shop) {
        self.shop = shop
    }
    
    deinit {
        requestCancellable?.cancel()
    }
    
    func loadImage() {
        let url = self.shop.photo.pc.l
        requestCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    print(error.localizedDescription)
                    self.image = Image("noimage")
                case .finished:
                    print("finished")
                }
            }, receiveValue: { [weak self] data, _ in
                guard
                    let self = self,
                    let uiImage = UIImage(data: data) else { return }
                self.image = Image(uiImage: uiImage)
            })
    }
}
