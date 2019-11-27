# お店検索アプリ

## MapView と SwiftUI

* <https://docs.mapbox.com/help/tutorials/ios-swiftui/>

## 参考になりそう？

* [人気の旅行APIをまとめてみた](https://qiita.com/cnakano/items/cf19cb541b2e952576b5)

## Hotpepper API

* [API仕様](https://webservice.recruit.co.jp/hotpepper/reference.html)
    * ドキュメントには **http** とあるが、実際には **https** でアクセス可能
    * 事前に **APIキー** を取得する必要あり（メアドを登録するだけ）
    * アクセス制限などはないっぽい？
* グルメサーチ
    * 位置情報やジャンルなど、ざっくりとした条件で検索する
    * https://webservice.recruit.co.jp/hotpepper/gourmet/v1/
    * https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=【APIキー】&lat=35.688382&lng=139.805927&range=5&order=4&format=json
* 店名サーチ
    * 店舗名や電話番号など、ある程度わかっている時に利用する
    * https://webservice.recruit.co.jp/hotpepper/shop/v1/
* 各種マスタ系はこんな感じ
    * 検索用ディナー予算マスタAPI
    * 大サービスエリアマスタAPI
    * サービスエリアマスタAPI
    * 大エリアマスタAPI
    * 中エリアマスタAPI
    * 小エリアマスタAPI
    * ジャンルマスタAPI
    * クレジットカードマスタAPI
    * 特集マスタAPI
    * 特集カテゴリマスタAPI

## TODO

* 位置情報の取得と利用
* 詳細画面にMapViewを表示
* MapViewに一覧情報をぽ表示するような感じで
* 条件指定してお店を探せるようにする？

