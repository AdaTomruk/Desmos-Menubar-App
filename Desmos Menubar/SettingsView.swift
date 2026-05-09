//
//  SettingsView.swift
//  Desmos Menubar
//
//  Created by Ada Tomruk on 9.05.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("windowWidth") private var windowWidth: Double = 400
    @AppStorage("windowHeight") private var windowHeight: Double = 600

    var body: some View {
        Form {
            Section("Window Size") {
                Stepper(value: $windowWidth, in: 300...1200, step: 20) {
                    Text("Width: \(Int(windowWidth))")
                }

                Stepper(value: $windowHeight, in: 300...1200, step: 20) {
                    Text("Height: \(Int(windowHeight))")
                }
            }
        }
        .padding(16)
        .frame(width: 360)
    }
}

#Preview {
    SettingsView()
}
