//
//  YucaBenApp.swift
//  YucaBen
//
//  Created by Cihat Bostancı on 20.02.2021.
//

import SwiftUI

@main
struct YucaBenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
