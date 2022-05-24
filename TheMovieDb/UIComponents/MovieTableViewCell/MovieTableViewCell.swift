//
//  MovieTableViewCell.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation
import UIKit

protocol MovieTableVieCellDelegate: AnyObject {
    func favoriteButtonTapped(at cell: MovieTableViewCell)
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: MovieTableVieCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImage.layer.cornerRadius = 8
        
        favoriteButton.setImage(UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(.init(scale: .default))?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        favoriteButton.setImage(UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(.init(scale: .default))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .selected)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favoriteButtonTapped(at: self)
        sender.bounce()
        
        let isFavorite = !favoriteButton.isSelected
        paintFavoriteButton(isFavorite: isFavorite)
    }
    
     func paintFavoriteButton(isFavorite: Bool) {
        favoriteButton.isSelected = isFavorite
    }
}
