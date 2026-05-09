//
//  Menubar.swift
//  Desmos Menubar
//
//  Created by Ada Tomruk on 6.11.2025.
//


import SwiftUI
import WebKit
import AppKit

struct Menubar: View {
    @AppStorage("windowWidth") private var windowWidth: Double = 400
    @AppStorage("windowHeight") private var windowHeight: Double = 600
    @AppStorage("extendIntoTitleBar") private var extendIntoTitleBar = true

    var body: some View {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            contentView(url: url)
                .frame(width: windowWidth, height: windowHeight)
                .background(WindowConfigurator(contentSize: NSSize(width: windowWidth, height: windowHeight), extendIntoTitleBar: extendIntoTitleBar))
        } else {
            Text("Erorr: index.html not found")
                .padding()
                .frame(width: 300, height: 100)
                .background(WindowConfigurator(contentSize: NSSize(width: 300, height: 100), extendIntoTitleBar: false))
        }
    }

    @ViewBuilder
    private func contentView(url: URL) -> some View {
        if extendIntoTitleBar {
            WebView(url: url)
                .ignoresSafeArea()
        } else {
            WebView(url: url)
        }
    }
}

#Preview {

    Menubar()

}

private struct WindowConfigurator: NSViewRepresentable {
    let contentSize: NSSize
    let extendIntoTitleBar: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> NSView {
        let view = ConfiguratorView(frame: .zero)
        view.coordinator = context.coordinator
        view.contentSize = contentSize
        view.extendIntoTitleBar = extendIntoTitleBar
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        guard let view = nsView as? ConfiguratorView else { return }
        view.contentSize = contentSize
        view.extendIntoTitleBar = extendIntoTitleBar
        view.applyWindowConfigurationIfPossible()
    }

    private final class ConfiguratorView: NSView {
        weak var coordinator: Coordinator?
        var contentSize: NSSize = .zero
        var extendIntoTitleBar = false

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            applyWindowConfigurationIfPossible()
        }

        func applyWindowConfigurationIfPossible() {
            guard let window else { return }
            coordinator?.configure(window: window, contentSize: contentSize, extendIntoTitleBar: extendIntoTitleBar)
        }
    }

    final class Coordinator {
        private weak var configuredWindow: NSWindow?
        private var lastAppliedContentSize: NSSize?
        private var lastAppliedExtendIntoTitleBar: Bool?

        func configure(window: NSWindow, contentSize: NSSize, extendIntoTitleBar: Bool) {
            if configuredWindow !== window {
                configuredWindow = window
                lastAppliedContentSize = nil
                lastAppliedExtendIntoTitleBar = nil
            }

            if !window.styleMask.contains(.titled) {
                window.styleMask.insert(.titled)
            }
            if window.styleMask.contains(.resizable) {
                window.styleMask.remove(.resizable)
            }
            if !window.isMovableByWindowBackground {
                window.isMovableByWindowBackground = true
            }

            if lastAppliedExtendIntoTitleBar != extendIntoTitleBar {
                if extendIntoTitleBar {
                    if !window.styleMask.contains(.fullSizeContentView) {
                        window.styleMask.insert(.fullSizeContentView)
                    }
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                } else {
                    if window.styleMask.contains(.fullSizeContentView) {
                        window.styleMask.remove(.fullSizeContentView)
                    }
                    window.titleVisibility = .visible
                    window.titlebarAppearsTransparent = false
                }

                lastAppliedExtendIntoTitleBar = extendIntoTitleBar
            }

            if window.contentMinSize != contentSize {
                window.contentMinSize = contentSize
            }
            if window.contentMaxSize != contentSize {
                window.contentMaxSize = contentSize
            }
            if lastAppliedContentSize != contentSize {
                window.setContentSize(contentSize)
                lastAppliedContentSize = contentSize
            }
        }
    }
}
