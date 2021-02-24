//
//  NetworkManager.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import Foundation



class NetworkManager {
    
    
    func fetchAllCharacters(_ page: Int,_ completionHandler: @escaping (AllCharactersModel?) -> Void) {
        guard let url = URL(string: "\(Urls.getAllCharacters.rawValue)\(page)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                print("\(error)")
            }
            
            if let responce = responce {
               
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                let objects = try? decoder.decode(AllCharactersModel.self, from: data)
                completionHandler(objects)
            }
        }
        task.resume()
    }
    
    
    func searchCharacters(_ quary: String,_ completionHandler: @escaping (AllCharactersModel?) -> Void) {
        guard let url = URL(string: "\(Urls.searchCharacters.rawValue)\(quary)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                print("\(error)")
            }
            
            if let responce = responce {
               
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                let objects = try? decoder.decode(AllCharactersModel.self, from: data)
                completionHandler(objects)
            }
        }
        task.resume()
    }
    
}
