//
//  MainTableViewCell.swift
//  RickMortyApp
//
//  Created by shizo663 on 24.02.2021.
//

import UIKit
import Kingfisher
class MainTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var aliveLabel: UILabel!
    
    //MARK: - LifeCycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Functions -
    func configure(_ result: Result?) {
        guard let result = result else { return }
        if let url = URL(string: result.image ?? " ") {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url)
        }
        nameLabel.text = result.name
        maleLabel.text = result.species
        aliveLabel.text = result.status
        switch result.status {
        case "Alive":
            aliveLabel.textColor = .green
        case "Dead":
            aliveLabel.textColor = .red
        default:
            aliveLabel.textColor = .black
            
        }
    }
    
    
    func configureFromCoreData(_ from: CharactersCoreData?) {
        guard let result = from else { return }
        if let url = URL(string: result.image ?? " ") {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url)
        }
        nameLabel.text = result.name
        aliveLabel.text = result.status
        switch result.status {
        case "Alive":
            aliveLabel.textColor = .green
        case "Dead":
            aliveLabel.textColor = .red
        default:
            aliveLabel.textColor = .black
            
        }
    }
    
}
