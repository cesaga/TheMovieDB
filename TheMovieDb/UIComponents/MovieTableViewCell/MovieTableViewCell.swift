//
//  MovieTableViewCell.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImage.layer.cornerRadius = 8
    }
    
    func configureCell(movieTitle: String, posterUrl: URL) {
        self.movieTitle.text = movieTitle
        movieImage.kfSetImage(for: posterUrl)
    }
}
