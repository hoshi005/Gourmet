//
//  TopView.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/12.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct TopView: View {
    
    @ObservedObject(initialValue: TopViewModel()) var viewModel
    
    private var updateButton: some View {
        Button(action: {
            self.viewModel.fetchHotpepper()
        }) {
            Image(systemName: "arrow.counterclockwise")
                .imageScale(.large)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.shops) { shop in
                    ShopRowView(shop: shop)
                }
            }
            .navigationBarTitle(Text("ちかくのお店"))
            .navigationBarItems(trailing: updateButton)
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
