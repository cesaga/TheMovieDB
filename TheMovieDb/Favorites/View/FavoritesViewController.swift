//
//  FavoritesViewController.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import Foundation
import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func showLoading()
    func stopLoading()
    func showFavoriteMovies(movies: [MovieModel])
    func removeMovie(movie: MovieModel)
}

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let favoritesViewModel: FavoritesViewModel
    var favoriteMovies: [MovieModel] = []
    
    init(favoritesViewModel: FavoritesViewModel) {
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: "FavoritesViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesViewModel.loadFavoriteMovies()
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate, MovieTableVieCellDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = favoriteMovies[indexPath.row]
        cell.delegate = self
        cell.movieTitle.text = movie.title
        cell.movieImage.kfSetImage(for: movie.posterUrl)
        cell.paintFavoriteButton(isFavorite: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = favoriteMovies[indexPath.row]
        let movieDetailViewModel = MovieDetailViewModel(movieDetailRepository: MovieDetailRepository(), creditsRepository: CreditsRepository())
        let movieDetailViewController = MovieDetailViewController(movie: movie, movieDetailViewModel: movieDetailViewModel)
        movieDetailViewModel.view = movieDetailViewController
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(145)
    }
    
    func favoriteButtonTapped(at cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let movie = favoriteMovies[indexPath.row]
        favoritesViewModel.starButtonTapped(movie: movie)
       
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func removeMovie(movie: MovieModel) {
//        favoriteMovies.removeAll { $0.id == movie.id }
//        tableView.reloadData()
    }
    
    func showLoading() {
        print("Loading")
    }
    
    func stopLoading() {
        print("Stop Loading")
    }
    
    func showFavoriteMovies(movies: [MovieModel]) {
        favoriteMovies = movies
        tableView.reloadData()
    }
}


