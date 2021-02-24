//
//  AllCharactersModel.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import Foundation

struct AllCharactersModel: Codable {
    let info: Info?
    let results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    var name: String?
    var status: String?
    let species: String?
    let type: String?
    var gender: String?
    let origin: Location?
    var location: Location?
    var image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}



// MARK: - Location
struct Location: Codable {
    var name: String?
    let url: String?
}
