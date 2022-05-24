//
//  VideoModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 24-05-22.
//

import Foundation

struct VideoModel: Codable {
    let id: Int?
    let results: [Video]
}

struct Video: Codable {
    let id: String?
    let key: String?
    let site: String?
    let size: Int?
    let type: String?
}
