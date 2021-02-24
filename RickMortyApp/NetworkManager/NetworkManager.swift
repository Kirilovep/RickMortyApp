//
//  NetworkManager.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import Foundation

class NetworkManager {
    
    var networkDataFetcher: DataFetcher?
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    
    func fetchAllCharacters(_ page: Int,_ completionHandler: @escaping (AllCharactersModel?) -> Void) {
        guard let url = URL(string: "\(Urls.getAllCharacters.rawValue)\(page)") else { return }
        
        networkDataFetcher?.fetchData(url: url, completionHandler)
    }
    
    
    func searchCharacters(_ quary: String,_ completionHandler: @escaping (AllCharactersModel?) -> Void) {
        guard let url = URL(string: "\(Urls.searchCharacters.rawValue)\(quary)") else { return }
        
        networkDataFetcher?.fetchData(url: url, completionHandler)
    
}
}
