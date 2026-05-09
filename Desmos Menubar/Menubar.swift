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
    var body: some View {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            WebView(url: url)
                .background(WindowConfigurator(minSize: NSSize(width: 400, height: 600)))
        } else {
            Text("Erorr: index.html not found")
                .padding()
                .frame(width: 300, height: 100)
                .background(WindowConfigurator(minSize: NSSize(width: 300, height: 100)))
        }
    }
}

#Preview {

    Menubar()

}

private struct WindowConfigurator: NSViewRepresentable {
    let minSize: NSSize

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> NSView {
        let view = ConfiguratorView(frame: .zero)
        view.coordinator = context.coordinator
        view.minSize = minSize
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        guard let view = nsView as? ConfiguratorView else { return }
        view.minSize = minSize
        view.applyWindowConfigurationIfPossible()
    }

    private final class ConfiguratorView: NSView {
        weak var coordinator: Coordinator?
        var minSize: NSSize = .zero

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            applyWindowConfigurationIfPossible()
        }

        func applyWindowConfigurationIfPossible() {
            guard let window else { return }
            coordinator?.configure(window: window, minSize: minSize)
        }
    }

    final class Coordinator {
        private weak var configuredWindow: NSWindow?
        private var didSetInitialSize = false

        func configure(window: NSWindow, minSize: NSSize) {
            if configuredWindow !== window {
                configuredWindow = window
                didSetInitialSize = false
            }

            if !window.styleMask.contains(.titled) {
                window.styleMask.insert(.titled)
            }
            if !window.styleMask.contains(.resizable) {
                window.styleMask.insert(.resizable)
            }
            if !window.isMovableByWindowBackground {
                window.isMovableByWindowBackground = true
            }
            if window.contentMinSize != minSize {
                window.contentMinSize = minSize
            }

            if !didSetInitialSize {
                window.setContentSize(minSize)
                didSetInitialSize = true
            }
        }
    }
}
