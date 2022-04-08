//
//  HomeCollectionViewCell.swift
//  Exercise
//
//  Created by Ankush Mahajan on 06/04/22.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 28.0)
        return label
    }()
    
    let labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(mainView)
        contentView.addSubview(imageView)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelDescription)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        labelTitle.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        labelTitle.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        labelDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        labelDescription.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        labelDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeCollectionViewCell {
    
    func configureCell(item: HomeCollectionCellViewModel?) {
        
        guard let data = item else {
            debugPrint("No item Found")
            return
        }
        
        labelTitle.text = data.homeDataModel?.title
        labelDescription.text = data.homeDataModel?.description
        
        guard let url = URL(string: data.homeDataModel?.imageHref ?? "") else {
            debugPrint("No URL Found")
            imageView.image = UIImage(named: "placeholder")
            return
        }
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, completionHandler: nil)
        
    }
}
