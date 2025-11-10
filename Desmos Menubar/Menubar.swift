//
//  Menubar.swift
//  Desmos Menubar
//
//  Created by Ada Tomruk on 6.11.2025.
//


import SwiftUI
import WebKit

struct Menubar: View {
    var body: some View {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            WebView(url: url)
        } else {
            Text("Erorr: index.html not found")
                .padding()
                .frame(width: 300, height: 100)
        }
    }
}

#Preview {

    Menubar()

}
