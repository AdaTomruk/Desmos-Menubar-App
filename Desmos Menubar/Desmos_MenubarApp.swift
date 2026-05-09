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
                .frame(minWidth: 400, idealWidth: 400, maxWidth: .infinity,
                       minHeight: 600, idealHeight: 600, maxHeight: .infinity)
            
        } label: {

            Image("MenuBarIcon")

        }
        .menuBarExtraStyle(.window)

    }

} 
