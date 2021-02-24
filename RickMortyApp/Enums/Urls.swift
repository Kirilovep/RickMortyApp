//
//  Urls.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import Foundation


enum Urls:String {
    case getAllCharacters = "https://rickandmortyapi.com/api/character/?page="
    case getSingleCharacter = "https://rickandmortyapi.com/api/character/"
    case searchCharacters = "https://rickandmortyapi.com/api/character/?name="
}
