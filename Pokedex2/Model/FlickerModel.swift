//
//  FlickerModel.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 08/07/2021.
//

import Foundation
struct FlickrResponse: Codable {
    let photos: FlickrResultsPage?
}
struct FlickrResultsPage: Codable {
    let page: Int
    let pages: Int
    let photo: [FlickPhoto]
}
struct FlickPhoto: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
}
