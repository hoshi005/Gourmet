//
//  TopViewModel.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/12.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

final class TopViewModel: NSObject, ObservableObject {
    
    @Published var response: HotPepperResponse?
    
    var locationManager = CLLocationManager()
    var location: CLLocation = CLLocation()
    var shops: [Shop] = []
    
    private let fetcher: HotpepperFetcher
    private var requestCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    init(fetcher: HotpepperFetcher = HotpepperFetcher()) {
        self.fetcher = fetcher
        super.init()
        self.locationManager.delegate = self
    }
    
    deinit {
        requestCancellable?.cancel()
    }
    
    
    /// 現在地の更新.
    func updateLocation() {
        print(#function)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    /// 位置情報から店舗検索.
    func fetchHotpepper() {
        print(#function)
        
        response = nil
        
        requestCancellable = fetcher.fetchGourmet(coordinate: self.location.coordinate)
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
                self.shops = response.results.shop
            })
    }
}


// MARK: - 位置情報関連.

extension TopViewModel: CLLocationManagerDelegate {
    
    /// 位置情報が更新されるたびに呼び出される.
    /// - Parameters:
    ///   - manager: CLLocationManager
    ///   - locations: 取得した位置情報.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        manager.stopUpdatingLocation()
        
        if let location = locations.first {
            self.location = location
            self.fetchHotpepper()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        switch status {
        case .notDetermined:
            print("ユーザーはこのアプリケーションに関してまだ選択を行っていません")
            manager.requestWhenInUseAuthorization() // 起動中のみの取得許可を求める
            break
        case .restricted:
            print("このアプリケーションは位置情報サービスを使用できません(ユーザによって拒否されたわけではありません)")
            break
        case .denied:
            print("ローケーションサービスの設定が「無効」になっています (ユーザーによって、明示的に拒否されています）")
            // 「設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい」を表示する
            break
        case .authorizedAlways:
            print("常時、位置情報の取得が許可されています。")
            // 位置情報取得の開始処理
            break
        case .authorizedWhenInUse:
            print("起動時のみ、位置情報の取得が許可されています。")
            manager.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
}
