//
//  DoraApp.swift
//  Dora
//
//  Created by Aravind on 20/01/24.
//

import SwiftUI
import SwiftData
class GlobalColors: ObservableObject {
    @Published var black : Color = .black
    @Published var white : Color = .white
    @Published var background : Color = .white
    func updateColors(for colorScheme : ColorScheme){
        if colorScheme == .dark{
            black = .white
            white = .gray
        }else{
            black = .black
            white = .white
        }
    }
}
@main
struct DoraApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        @StateObject var globalColors = GlobalColors()
        @Environment(\.colorScheme) var colorScheme
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(globalColors)
    }
}
