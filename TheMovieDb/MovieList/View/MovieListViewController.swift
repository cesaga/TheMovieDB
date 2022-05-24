//
//  MovieListViewController.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import Foundation
import UIKit
import Kingfisher

protocol MovieListViewProtocol: AnyObject {
    func showLoading()
    func stopLoading()
    func showMovies(movies: [MovieModel])
}

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let movieListViewModel: MovieListViewModel
    var movies: [MovieModel] = []
    
    init(movieListViewModel: MovieListViewModel) {
        self.movieListViewModel = movieListViewModel
        super.init(nibName: "MovieListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        movieListViewModel.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
    }
}
    
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate, MovieTableVieCellDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.delegate = self
        cell.movieTitle.text = movie.title
        cell.movieImage.kfSetImage(for: movie.posterUrl)
        FavoritesManager.shared.favorites.contains(where: {$0.id == movie.id}) ? cell.paintFavoriteButton(isFavorite: true) :  cell.paintFavoriteButton(isFavorite: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let movieDetailViewModel = MovieDetailViewModel(movieDetailRepository: MovieDetailRepository(),
                                                        creditsRepository: CreditsRepository())
        let movieDetailViewController = MovieDetailViewController(movie: movie, movieDetailViewModel: movieDetailViewModel)
        movieDetailViewModel.view = movieDetailViewController
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 3 {
            movieListViewModel.fetchMovies(nextPage: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(145)
    }
    
    func favoriteButtonTapped(at cell: MovieTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        let movie = movies[indexPath.row]
        movieListViewModel.starButtonTapped(movie: movie)
    }
}

extension MovieListViewController: MovieListViewProtocol {

    func showLoading() {
        print("Loading")
    }
    
    func stopLoading() {
        print("Stop Loading")
    }
    
    func showMovies(movies: [MovieModel]) {
        self.movies.append(contentsOf: movies)
        tableView.reloadData()
    }
}
