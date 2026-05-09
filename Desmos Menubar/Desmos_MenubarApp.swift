//
//  Desmos_MenubarApp.swift
//  Desmos Menubar
//
//  Created by Ada Tomruk on 6.11.2025.
//

import SwiftUI
import AppKit

@main
struct DesmosMenubarApp: App {

    var body: some Scene {
        MenuBarExtra {
            Menubar()
        } label: {
            Image("MenuBarIcon")
        } menu: {
            SettingsLink()
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
        }
    }

} 
