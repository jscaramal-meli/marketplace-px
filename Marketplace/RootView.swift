//
//  RootView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationView {
            HStack(alignment: .center, spacing: 20) {
                SearchView(text: $searchText)
                
                NavigationLink(destination: ProductListView(searchText: $searchText)) {
                   Text("Buscar")
                }.buttonStyle(DefaultButtonStyle())
                    .padding(.trailing, 20)
                
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
