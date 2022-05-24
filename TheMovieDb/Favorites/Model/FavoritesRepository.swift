//
//  FavoritesRepository.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 24-05-22.
//

import Foundation

protocol FavoritesRepositoryProtocol: AnyObject {
    func loadFavoriteMovies() -> [MovieModel]
}

final class FavoritesRepository: FavoritesRepositoryProtocol {
    
    let storage: MovieStorage
    
    init(storage: MovieStorage) {
        self.storage = storage
    }
    
    func loadFavoriteMovies() -> [MovieModel] {
        return storage.getAllStorageMovies()
    }
}
