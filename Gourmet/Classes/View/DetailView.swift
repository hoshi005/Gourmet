//
//  DetailView.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/14.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        Text(viewModel.shop.name)
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
