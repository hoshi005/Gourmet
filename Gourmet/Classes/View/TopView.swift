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
    
    @State var showModal: Bool = false
    @State var selectedShop: Shop?
    
    private var updateButton: some View {
        Button(action: {
//            self.viewModel.fetchHotpepper()
            self.viewModel.updateLocation()
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
                        .onTapGesture {
                            self.selectedShop = shop
                            self.showModal.toggle()
                    }
                    .sheet(isPresented: self.$showModal, onDismiss: {
                        print("@@@ dismiss modal view !")
                    }) {
                        if self.selectedShop != nil {
                            DetailView(shop: self.selectedShop!)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("ちかくのお店"))
            .navigationBarItems(trailing: updateButton)
//            .onAppear { self.viewModel.fetchHotpepper() }
            .onAppear { self.viewModel.updateLocation() }
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
