//
//  Desmos_MenubarApp.swift
//  Desmos Menubar
//
//  Created by Ada Tomruk on 6.11.2025.
//

import SwiftUI

@main
struct DesmosMenubarApp: App {

    var body: some Scene {
        
        MenuBarExtra {
            
            Menubar()
                .frame(width: 400, height: 600)
            
        } label: {

            Image("MenuBarIcon")

        }
        .menuBarExtraStyle(.window)

    }

} 
