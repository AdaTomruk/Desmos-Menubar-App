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

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        loadIfNeeded(in: webView, coordinator: context.coordinator)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        loadIfNeeded(in: nsView, coordinator: context.coordinator)
    }

    private func loadIfNeeded(in webView: WKWebView, coordinator: Coordinator) {
        let standardizedURL = url.standardizedFileURL
        guard coordinator.lastLoadedURL != standardizedURL else { return }

        coordinator.lastLoadedURL = standardizedURL
        webView.loadFileURL(standardizedURL, allowingReadAccessTo: standardizedURL.deletingLastPathComponent())
    }

    final class Coordinator {
        var lastLoadedURL: URL?
    }
}
