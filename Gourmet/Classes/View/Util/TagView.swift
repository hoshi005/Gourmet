//
//  TagView.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/13.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct TagView: View {
    
    var shop: Shop
    
    var body: some View {
        HStack(spacing: 2) {
            
            // ジャンル.
            Text(shop.genre.name)
                .modifier(TagBaseLayout(color: .tag))
            
            // サブジャンル.
            if shop.subGenre != nil {
                Text(shop.subGenre!.name)
                    .modifier(TagBaseLayout(color: .tag))
            }
        }
    }
}


/// タグアイコン用のベーシックなレイアウトを定義.
struct TagBaseLayout: ViewModifier {
    
    var color: Color
    var background: Color = .clear
    
    public func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(2.0)
            .border(color)
            .foregroundColor(color)
            .background(background)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(shop: Shop.dummy)
            .previewLayout(.sizeThatFits)
    }
}
