//
//  HotpepperFetcher.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/12.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Combine
import CoreLocation


class HotpepperFetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}


extension HotpepperFetcher: HotpepperFetchable {
    
    /// 位置情報による検索.
    /// - Parameter coordinate: 位置情報.
    func fetchGourmet(
        coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.688382, longitude: 139.805927)
    ) -> AnyPublisher<HotPepperResponse, HotpepperError> {
        return fetchHotpepper(with: gourmetSearchComponents(coordinate: coordinate))
    }
    
    
    /// 検索ワードによる検索.
    /// - Parameter query: 検索ワード.
    func fetchShop(query: String) -> AnyPublisher<HotPepperResponse, HotpepperError> {
        return fetchHotpepper(with: shopSearchComponents(query: query))
    }
    
    
    /// 検索処理.
    /// - Parameter components: URL情報.
    private func fetchHotpepper<T>(with components: URLComponents) -> AnyPublisher<T, HotpepperError> where T: Decodable {
        
        guard let url = components.url else {
            let error = HotpepperError.network(description: "URLが不正です.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { HotpepperError.network(description: $0.localizedDescription) }
            
//         // 最初の値のみ、という指定ができるみたい.
//            .flatMap(maxPublishers: .max(1)) { decode($0.data) }
//            .eraseToAnyPublisher()
        
            .flatMap { decode($0.data) }
            .eraseToAnyPublisher()
            
//         // デコード系の処理をこっちでやるならこんな感じ.
//            .map { $0.data }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError { HotpepperError.parsing(description: $0.localizedDescription) }
//            .eraseToAnyPublisher()
    }
}

// MARK: - URLの組み立てとか.

private extension HotpepperFetcher {
    
    struct HotpepperAPI {
        static let scheme = "https"
        static let host = "webservice.recruit.co.jp"
        static let gourmetPath = "/hotpepper/gourmet/v1/"
        static let shopPath = "/hotpepper/shop/v1/"
    }
    
    /// グルメサーチ用のURLComponent生成.
    /// - Parameter coordinate: 位置情報.
    func gourmetSearchComponents(coordinate: CLLocationCoordinate2D) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = HotpepperAPI.scheme
        components.host = HotpepperAPI.host
        components.path = HotpepperAPI.gourmetPath
        
        components.queryItems = [
            URLQueryItem(name: "key", value: Const.API.key),
            URLQueryItem(name: "range", value: "5"),
            URLQueryItem(name: "order", value: "4"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
            URLQueryItem(name: "lng", value: "\(coordinate.longitude)")
        ]
        
        debugPrint(components.url?.absoluteURL ?? "(non value)")
        return components
    }
    
    
    /// 店名サーチ用のURLComponent生成.
    /// - Parameter query: 検索ワード.
    func shopSearchComponents(query: String) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = HotpepperAPI.scheme
        components.host = HotpepperAPI.host
        components.path = HotpepperAPI.shopPath
        
        components.queryItems = [
            URLQueryItem(name: "key", value: Const.API.key),
            URLQueryItem(name: "keyword", value: query)
        ]
        
        debugPrint(components.url?.absoluteURL ?? "(non value)")
        return components
    }
}

// MARK: - デコード.

fileprivate func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, HotpepperError> {
    
    let decoder = JSONDecoder()
    // TODO: デコード系でなにかあればここで.
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { HotpepperError.parsing(description: $0.localizedDescription) }
        .eraseToAnyPublisher()
}
