//
//  DetailViewController.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //MARK: - TableView
    var detailCharacters: Result?
    var savedCharacters: CharactersCoreData?
    //MARK: - IBOutlet -
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - lifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    //MARK: - Functions - 
    
    func setUpView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        addButton()
        
        if detailCharacters == nil {
            nameLabel.text = savedCharacters?.name
            statusLabel.text = savedCharacters?.status
            genderLabel.text = savedCharacters?.gender
            locationLabel.text = savedCharacters?.location
            if let url = URL(string: savedCharacters?.image ?? " ") {
                photoImageView.kf.indicatorType = .activity
                photoImageView.kf.setImage(with: url)
            }
            
            switch savedCharacters?.status {
            case "Alive":
                statusLabel.textColor = .green
            case "Dead":
                statusLabel.textColor = .red
            default:
                statusLabel.textColor = .black
                
            }
        } else {
            nameLabel.text = detailCharacters?.name
            statusLabel.text = detailCharacters?.status
            speciesLabel.text = detailCharacters?.species
            genderLabel.text = detailCharacters?.gender
            locationLabel.text = detailCharacters?.location?.name
            
            if let url = URL(string: detailCharacters?.image ?? " ") {
                photoImageView.kf.indicatorType = .activity
                photoImageView.kf.setImage(with: url)
            }
            
            switch detailCharacters?.status {
            case "Alive":
                statusLabel.textColor = .green
            case "Dead":
                statusLabel.textColor = .red
            default:
                statusLabel.textColor = .black
            }
        }
  
    }
    
    func addButton() {
        let likeTappedButton = UIBarButtonItem(image: #imageLiteral(resourceName: "like"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = likeTappedButton
    }
    
    @objc func addTapped() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let charactersData = CharactersCoreData(context: context)
        charactersData.name = detailCharacters?.name
        charactersData.gender = detailCharacters?.gender
        charactersData.location = detailCharacters?.location?.name
        charactersData.status = detailCharacters?.status
        charactersData.image = detailCharacters?.image
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "heart")
    }
}
