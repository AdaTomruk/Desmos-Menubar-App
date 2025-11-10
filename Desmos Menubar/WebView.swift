//
//  WebView.swift
//  Desmos Menubar
//
//  Created by Ada Tomruk on 6.11.2025.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}
