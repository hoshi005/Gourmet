//
//  TopViewModel.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/12.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Combine

final class TopViewModel: ObservableObject {
    
    @Published var response: HotPepperResponse?
    
    private let fetcher: HotpepperFetcher
    private var requestCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    init(fetcher: HotpepperFetcher = HotpepperFetcher()) {
        self.fetcher = fetcher
    }
    
    deinit {
        requestCancellable?.cancel()
    }
    
    var shops: [Shop] {
        response?.results.shop ?? []
    }
    
    func fetchHotpepper() {
        print(#function)
        
        response = nil
        
        requestCancellable = fetcher.fetchGourmet()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    self.response = nil
                    print("error = \(error.localizedDescription)")
                case .finished:
                    print("finished")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.response = response
            })
    }
}
