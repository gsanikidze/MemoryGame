//
//  Memory_GameApp.swift
//  Memory Game
//
//  Created by Guram Sanikidze on 01.04.23.
//

import SwiftUI

@main
struct Memory_GameApp: App {
    var vm = MemoryGameVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm)
        }
    }
}
