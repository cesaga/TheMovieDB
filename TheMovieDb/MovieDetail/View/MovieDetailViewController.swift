//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation
import UIKit
import YoutubePlayer

protocol MovieDetailViewProtocol: AnyObject {
    func showLoading()
    func stopLoading()
    func showMovieDetail(movie: MovieModel)
    func showActors(actors:[ActorModel])
    func showMovieTrailer(trailer: Video)
}

class MovieDetailViewController: UIViewController {
        
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var youtubeView: YTPlayerView!
    
    let movieDetailViewModel: MovieDetailViewModel
    var movie: MovieModel
    var actors: [ActorModel] = []
    
    init(movie: MovieModel, movieDetailViewModel: MovieDetailViewModel) {
        self.movie = movie
        self.movieDetailViewModel = movieDetailViewModel
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()
        fetchMovieDetailAndCredits()
        navigationItem.title = "Movie Detail"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFavoriteButton()
    }
    
    private func registerCell() {
        
        let nib = UINib(nibName: "ActorCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "ActorCollectionViewCell")
    }
    
    private func configureView() {
        
        movieImage.kfSetImage(for: movie.posterUrl)
        movieTitle.text = movie.title
        releaseDate.text = movie.release_date
        runtime.text = setupRuntimeLabel()
        tagline.text = movie.tagline
        movieOverview.text = movie.overview
    }
    
    private func fetchMovieDetailAndCredits() {
        
        if let movieId = movie.id {
            movieDetailViewModel.fetchMovieDetail(movieId: movieId)
            movieDetailViewModel.fetchCredits(moviId: movieId)
            movieDetailViewModel.fetchMovieTrailer(movieId: movieId)
        }
    }
    
    private func minutesToHoursAndMinutes(_ minutes : Int) -> (movieHours : Int , movieMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    private func setupRuntimeLabel() -> String {
        let minutesToHour = minutesToHoursAndMinutes(movie.runtime ?? 0)
        if movie.runtime == 0 {
            return ""
        }
        else if minutesToHour.movieHours == 0 {
            return "\(minutesToHour.movieMinutes)m"
        }
        else {
            return "\(minutesToHour.movieHours)h \(minutesToHour.movieMinutes)m"
        }
    }
    
    @IBAction func saveFavoriteButton(_ sender: UIButton) {
        sender.bounce()
        
        let isFavorite = !favoriteButton.isSelected
        paintFavoriteButton(isFavorite)
        
//        if let index = FavoritesManager.shared.favorites.firstIndex(where: {$0.id == movie.id}) {
//            FavoritesManager.shared.favorites.remove(at: index)
//        } else {
//            FavoritesManager.shared.favorites.insert(movie, at: 0)
//        }
//        FavoritesManager.shared.save()
    }
    
    private func paintFavoriteButton(_ isFavorite: Bool) {
        self.favoriteButton.isSelected = isFavorite
    }
    
    private func setupFavoriteButton() {
        
        self.favoriteButton.setImage(UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(.init(scale: .large))?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        self.favoriteButton.setImage(UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(.init(scale: .large))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .selected)
        
        FavoritesManager.shared.favorites.contains(where: {$0.id == movie.id}) ? paintFavoriteButton(true) :
            paintFavoriteButton(false)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell else {
            return UICollectionViewCell()
        }
        let actor = actors[indexPath.row]
        cell.actorImage.kfSetImage(for: actor.profileUrl)
        cell.actorName.text = actor.name
        cell.actorCharacter.text = actor.character
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actor = actors[indexPath.row]
        let actorDetailViewModel = ActorDetailViewModel(actorDetailRepository: ActorDetailRepository(), moviesForActorRepository: MoviesForActorRepository())
        let actorDetailViewController = ActorDetailViewController(actor: actor, actorDetailViewModel: actorDetailViewModel)
        actorDetailViewModel.view = actorDetailViewController
        navigationController?.pushViewController(actorDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 172, height: 320)
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func showLoading() {
        print("Loading")
    }
    
    func stopLoading() {
        print("Stop Loading")
    }
    
    func showMovieDetail(movie: MovieModel) {
        self.movie = movie
        self.movieGenre.text = movie.prettyGenres
        configureView()
    }
    
    func showActors(actors: [ActorModel]) {
        self.actors = actors
        collectionView.reloadData()
    }
    
    func showMovieTrailer(trailer: Video) {
        youtubeView.loadWith(videoId: trailer.key ?? "", playerVars: ["playsinline" : 1])
    }
}
