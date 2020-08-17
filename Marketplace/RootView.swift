//
//  RootView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct RootView: View {    
    var body: some View {
        NavigationView {
            SearchView()
                .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
