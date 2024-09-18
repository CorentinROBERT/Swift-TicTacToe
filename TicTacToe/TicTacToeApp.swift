//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Corentin Robert on 16/09/2024.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(controler:GameControler())
        }
    }
}
