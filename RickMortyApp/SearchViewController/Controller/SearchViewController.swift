//
//  SearchViewController.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    //MARK:- Properties -
    
    var charactersData: [Result] = []
    let networkManager = NetworkManager()
    var quary = ""
    //MARK: - IBOutlets -
    
    @IBOutlet weak var searchTableView: UITableView! { didSet {
        let nib = UINib(nibName: Cells.mainTableViewNib.rawValue, bundle: nil)
        
        searchTableView.register(nib, forCellReuseIdentifier: Cells.mainTableViewIdentifier.rawValue)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = 125
    }
    
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.showsCancelButton = true
        }
    }
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Functions -
    private func searchCharacters(_ quary: String) {
        networkManager.searchCharacters(quary) { [weak self] (findCharacters) in
            guard let self = self else { return }
            self.charactersData = findCharacters?.results ?? []
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
}

//MARK: - TableView extension -
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainTableViewIdentifier.rawValue, for: indexPath) as! MainTableViewCell
        
        cell.configure(charactersData[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: VC.detailVC.rawValue) as! DetailViewController
        vc.detailCharacters = charactersData[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

//MARK: SearchBar extension -
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchQuary = searchBar.text else { return }
        quary = searchQuary
        searchCharacters(quary)
        searchTableView.reloadData()
        
        if searchBar.text?.isEmpty == true {
            quary = ""
            charactersData = []
            searchTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        charactersData = []
        searchTableView.reloadData()
        if searchBar.text?.isEmpty == true {
            view.endEditing(true)
        } else {
            searchBar.text? = ""
            view.endEditing(true)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty == true {
            charactersData = []
            searchTableView.reloadData()
        }
        
        view.endEditing(true)
    }
}
