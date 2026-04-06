//
//  FriendsFavoriteMoviesApp.swift
//  FriendsFavoriteMovies
//
//  Created by Victoria Vavulina on 4.4.2026.
//

import SwiftUI
import SwiftData

@main
struct FriendsFavoriteMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Friend.self, Movie.self]) { result in
            guard let container = try? result.get() else { return }
            let context = container.mainContext

            // Only seed if the store is empty
            let friendCount = (try? context.fetchCount(FetchDescriptor<Friend>())) ?? 0
            guard friendCount == 0 else { return }

            for friend in Friend.sampleData { context.insert(friend) }
            for movie in Movie.sampleData { context.insert(movie) }
            try? context.save()
        }
    }
}
