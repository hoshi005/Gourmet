//
//  ShopRowView.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/13.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct ShopRowView: View {
    
    var shop: Shop
    
    var body: some View {
        VStack(alignment: .leading) {
            TagView(shop: shop)
            Text(shop.name)
                .font(.headline)
            Text(shop.address)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct ShopRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShopRowView(shop: .dummy)
            .previewLayout(.sizeThatFits)
    }
}
