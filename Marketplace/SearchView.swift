//
//  SearchView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText : String = ""
    
    @State private var isShowingProducts = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            
            Text("Marketplace")
                .font(.system(size: 40))
                .padding(.bottom, -8)
                .padding(.horizontal, 16)
                .foregroundColor(Color.init(hex: "003459"))
            
            Text("Encontrá eso que necesitás")
                .font(Font.custom("New York", size: 23))
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
                .foregroundColor(Color.init(hex: "007EA7"))
            
            TextField("   Buscar...", text: self.$searchText)
            .padding(7)
            .background(Color(.systemGray6))
            .font(.system(size: 18))
            .cornerRadius(20)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            HStack {
                Spacer()
                Button(action: {
                    self.isShowingProducts = true
                }) {
                    Image(systemName: "arrow.right")
                    .padding()
                    .background(Color.init(hex: "003459"))
                    .clipShape(Circle())
                    .font(.largeTitle)
                    .foregroundColor(Color.init(hex: "00A8E8"))
                }
                .padding(.trailing, 16)
            }
                            
            NavigationLink(destination: ProductsView(searchText: self.$searchText), isActive: $isShowingProducts) { EmptyView() }
       
            Spacer()
                
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: endEditing)
    }
    
    func endEditing () {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
