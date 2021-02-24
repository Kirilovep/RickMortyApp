//
//  ViewController.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties -
    var charactersData: [Result] = []
    var totalPages: Int?
    var currentPage = 1
    let networkManager = NetworkManager()
    //MARK: - IBOutlets -
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: Cells.mainTableViewNib.rawValue, bundle: nil)
            mainTableView.register(nib, forCellReuseIdentifier: Cells.mainTableViewIdentifier.rawValue)
            mainTableView.delegate = self
            mainTableView.dataSource = self
            mainTableView.rowHeight = 125
        }
    }
    
    //MARK: - LifeCycle - 
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCharacters()
      
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Functions -
    
    private func fetchAllCharacters() {
        networkManager.fetchAllCharacters(currentPage) { [weak self] (characters) in
            guard let self = self else { return }
            self.totalPages = characters?.info?.pages
            self.charactersData.append(contentsOf: characters?.results ?? [])
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
    private func loadMore() {
        currentPage += 1
        fetchAllCharacters()
    }
}

//MARK: - TableViewDelegate extension -
extension MainViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainTableViewIdentifier.rawValue, for: indexPath) as! MainTableViewCell
        cell.configure(charactersData[indexPath.row])
        
        if indexPath.row == charactersData.count - 1 && currentPage <= totalPages ?? 1 {
            loadMore()
        }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: VC.detailVC.rawValue) as! DetailViewController
        vc.detailCharacters = charactersData[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

