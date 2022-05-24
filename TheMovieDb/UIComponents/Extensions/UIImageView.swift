//
//  UIImageView.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 24-05-22.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func kfSetImage(for url: URL) {
        
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler:
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        self.image = nil
                        print("Job failed: \(error.localizedDescription)")
                    }
                })
    }
}
