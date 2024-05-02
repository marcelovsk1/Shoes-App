//
//  ContentView.swift
//  ShoesApp_2
//
//  Created by Marcelo Amaral Alves on 2024-05-01.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelectedValue = 0
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    HomePage()
}
