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
            self.viewModel.updateLocation()
        }) {
            Image(systemName: "arrow.counterclockwise")
                .imageScale(.large)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                MapView(userLocation: $viewModel.location, shops: $viewModel.shops)
                    .frame(height: 300)
                    .shadow(color: Color.black.opacity(0.4), radius: 4)
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
            }
            .navigationBarTitle(Text("ちかくのお店"), displayMode: .inline)
            .navigationBarItems(trailing: updateButton)
            .onAppear { self.viewModel.updateLocation() }
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
