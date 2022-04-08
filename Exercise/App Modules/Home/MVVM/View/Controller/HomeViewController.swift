//
//  HomeViewController.swift
//  Exercise
//
//  Created by Ankush Mahajan on 05/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeViewModel = HomeViewModel()
    
    let navigationView: UIView = {
        let navView = UIView()
        navView.translatesAutoresizingMaskIntoConstraints = false
        return navView
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
}

extension HomeViewController {
    
    func initialSetup() {
                
        homeViewModel.setupData()
        homeViewModel.blockHomeData = {[weak self] in
            
            DispatchQueue.main.async {
                self?.setupData()
                self?.collectionView.reloadData()
            }
            
        }
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.lightGray
        view.addSubview(navigationView)
        navigationView.addSubview(labelTitle)
        view.addSubview(collectionView)
        
        // Navigation View
        navigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.window().safeAreaInsets.top).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // Title Label
        labelTitle.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        
        // CollectionView
        collectionView.collectionViewLayout = homeViewModel.collectionLayout
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: homeViewModel.collectionCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
               
        collectionView.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupData() {
        labelTitle.text = homeViewModel.homeData?.title
    }
}


//MARK: CollectionView Delegate Methods

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.arrayHomeCollectionCellVM?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeViewModel.collectionCellID, for: indexPath) as? HomeCollectionViewCell else {
            debugPrint("No cell Found")
            return UICollectionViewCell()
        }
        cell.configureCell(item: homeViewModel.arrayHomeCollectionCellVM?[indexPath.item])
        return cell
    }
}

//MARK: - CollectionView Waterfall Layout Delegate Methods (Required)

extension HomeViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        homeViewModel.calculateCollectionCellSize(indexPath: indexPath, collectionWidth: collectionView.bounds.width)
        debugPrint("Cell Size ====", homeViewModel.collectionCellSize)
        return homeViewModel.collectionCellSize
    }
    
}








