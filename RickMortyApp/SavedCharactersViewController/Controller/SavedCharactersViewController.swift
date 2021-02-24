//
//  SavedCharactersViewController.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import UIKit

class SavedCharactersViewController: UIViewController {

    //MARK: - Properties -
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedCharacters: [CharactersCoreData]? = []
    
    //MARK: - IBOutlets -
    @IBOutlet weak var savedTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: Cells.mainTableViewNib.rawValue, bundle: nil)
            savedTableView.register(nib, forCellReuseIdentifier: Cells.mainTableViewIdentifier.rawValue)
            savedTableView.delegate = self
            savedTableView.dataSource = self
            savedTableView.rowHeight = 125
        }
    }
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    //MARK: - Functions -
    func getData() {
        do {
            savedCharacters = try context.fetch(CharactersCoreData.fetchRequest())
            savedTableView.reloadData()
        } catch {
            print("Fetching Failed")
        }
    }

}


    //MARK: - TableView extension -
extension SavedCharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCharacters?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainTableViewIdentifier.rawValue, for: indexPath) as! MainTableViewCell
        
        cell.configureFromCoreData(savedCharacters?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: VC.detailVC.rawValue) as! DetailViewController

        vc.savedCharacters = savedCharacters?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let task = savedCharacters?[indexPath.row] else { return  }
            context.delete(task)
            savedCharacters?.remove(at: indexPath.row)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
         
        }
        savedTableView.reloadData()
    }
    
}
