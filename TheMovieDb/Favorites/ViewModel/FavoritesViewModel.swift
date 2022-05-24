//
//  FavoritesViewModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation

protocol MovieStorage {
    func save(movie: MovieModel)
    func contains(movie: MovieModel) -> Bool
    func remove(movie: MovieModel)
    func getAllStorageMovies() -> [MovieModel]
}

@MainActor
final class FavoritesViewModel {
    
    weak var view: FavoritesViewProtocol?
    private let favoritesRepository: FavoritesRepositoryProtocol
    private let storage: MovieStorage
    
    init(favoritesRepository: FavoritesRepositoryProtocol, storage: MovieStorage) {
        self.favoritesRepository = favoritesRepository
        self.storage = storage
    }
    
    func loadFavoriteMovies() {
        view?.showLoading()
        
        let favoritesMovies = favoritesRepository.loadFavoriteMovies()
        view?.showFavoriteMovies(movies: favoritesMovies)
        
        view?.stopLoading()
    }
    
    func starButtonTapped(movie: MovieModel) {
        storage.remove(movie: movie)
        loadFavoriteMovies()
//        view?.removeMovie(movie: movie)
    }
}
