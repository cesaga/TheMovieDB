//
//  UIButton.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 24-05-22.
//

import UIKit

extension UIButton {
    
    func bounce() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }) { (completion) in
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        }
    }
}
