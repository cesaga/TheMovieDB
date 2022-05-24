//
//  FavoritesManager.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation

class FavoritesManager {
    
    static let shared = FavoritesManager()
    
    var favorites: [MovieModel] = []
    
    private init() {
        load()
    }
    
    private let defaults = UserDefaults.standard
    private let myKey = "Favorites"
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: myKey) else { return }
        let decoder = JSONDecoder()
        let movies = try? decoder.decode([MovieModel].self, from: data)
        self.favorites = movies ?? []
    }
}

extension FavoritesManager: MovieStorage {
    func contains(movie: MovieModel) -> Bool {
        return favorites.contains { $0.id == movie.id }
    }
    
    func remove(movie: MovieModel) {
        favorites.removeAll { $0.id == movie.id }
        saveChanges()
    }
    
    func save(movie: MovieModel) {
        favorites.insert(movie, at: 0)
        saveChanges()
    }
    
    func getAllStorageMovies() -> [MovieModel] {
        return favorites
    }
    
    private func saveChanges() {
        let encoder = JSONEncoder()
        DispatchQueue.main.async {
            guard let data = try? encoder.encode(self.favorites) else { return }
            UserDefaults.standard.set(data, forKey: self.myKey)
            UserDefaults.standard.synchronize()
        }
    }
}
