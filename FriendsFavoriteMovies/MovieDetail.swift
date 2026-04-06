//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Victoria Vavulina on 6.4.2026.
//

import SwiftUI
import SwiftData

struct MovieDetail: View {
    @Bindable var movie: Movie
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(movie: Movie, isNew: Bool = false) {
        self.movie = movie
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Movie title", text: $movie.title)
            
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
        }
        .navigationTitle(isNew ? "New Movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview("Movie Detail - Sample or Fallback") {
    NavigationStack {
        if let sample = SampleData.shared.movie {
            MovieDetail(movie: sample)
        } else {
            // Fallback sample movie for preview purposes
            let fallback = Movie(title: "Preview Movie", releaseDate: .now)
            MovieDetail(movie: fallback, isNew: true)
        }
    }
}

#Preview("Movie Detail - Fresh Instance") {
    NavigationStack {
        MovieDetail(movie: Movie(title: "Another Movie", releaseDate: .now))
    }
}
#Preview {
    NavigationStack {
        if let movie = SampleData.shared.movie {
            MovieDetail(movie: movie)
        } else {
            // Fallback sample for preview when SampleData has no movie
            MovieDetail(movie: Movie(title: "Preview Movie", releaseDate: .now), isNew: true)
        }
    }
}

