//
//  DetailView.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/14.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 4) {
                    TagView(shop: viewModel.shop)
                    
                    Text(viewModel.shop.name)
                        .font(.headline)
                    
                    Text(viewModel.shop.catch)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack {
                        Image("noimage")
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text(viewModel.shop.address)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(viewModel.shop.access)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(Text(viewModel.shop.name), displayMode: .inline)
            .navigationBarItems(trailing: self.dismissButton)
        }
    }
    
    private var dismissButton: some View {
        Button("閉じる") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    init(shop: Shop) {
        self.viewModel = DetailViewModel(shop: shop)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(shop: .dummy)
    }
}
