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
        let view = NSView(frame: .zero)
        context.coordinator.view = view
        configureIfPossible(context: context)
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        configureIfPossible(context: context)
    }

    private func configureIfPossible(context: Context) {
        DispatchQueue.main.async {
            guard let view = context.coordinator.view, let window = view.window else { return }

            window.styleMask.insert(.titled)
            window.styleMask.insert(.resizable)
            window.isMovableByWindowBackground = true
            window.minSize = minSize

            if !context.coordinator.didSetInitialSize {
                window.setContentSize(minSize)
                context.coordinator.didSetInitialSize = true
            }
        }
    }

    final class Coordinator {
        weak var view: NSView?
        var didSetInitialSize = false
    }
}
