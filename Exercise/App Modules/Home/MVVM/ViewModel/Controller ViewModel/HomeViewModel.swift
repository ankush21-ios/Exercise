//
//  HomeViewModel.swift
//  Exercise
//
//  Created by Ankush Mahajan on 07/04/22.
//

import Foundation
import UIKit

class HomeViewModel {
    
    typealias BlockHomeDataLoaded = () -> ()
    
    let collectionCellID = CollectionViewCellID.homeCollectionCell.rawValue
    var collectionLayout: CHTCollectionViewWaterfallLayout!
    var collectionCellSize = CGSize()

    var errorString: String?
    var homeData: HomeModel?
    var arrayHomeCollectionCellVM: [HomeCollectionCellViewModel]?
    var blockHomeDataLoaded: BlockHomeDataLoaded?
}


extension HomeViewModel {
    
    func setupData() {
        configureCollectionLayout()
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: APIURL.home) else {
            debugPrint("URL not found")
            return
        }
        
        Webservice().load(resource: Resource<HomeModel>(url: url)) { [weak self] result in
            
            switch result {
            case .success(let data):
                debugPrint(data)
                self?.homeData = data
                self?.createArrayHomeCollectionCellVM()
                self?.errorString = nil
                self?.blockHomeDataLoaded?()
                
            case .failure(let error):
                debugPrint(error)
                
                self?.errorString = error.rawValue
                self?.homeData = nil
                self?.createArrayHomeCollectionCellVM()
                self?.blockHomeDataLoaded?()
            }
            
        }
        
    }
    
    func createArrayHomeCollectionCellVM() {
        let array = homeData?.rows?.map({ HomeCollectionCellViewModel(homeDataModel: $0) })
        arrayHomeCollectionCellVM = array
    }
    
}

extension HomeViewModel {
    
    func configureCollectionLayout() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.columnCount = UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1
        collectionLayout = layout
    }
    
    func calculateCollectionCellSize(indexPath: IndexPath, collectionWidth: CGFloat) {
        
        var cellWidth: CGFloat = 0.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellWidth = (UIScreen.main.bounds.width - 20 - collectionLayout.minimumColumnSpacing)/Double(collectionLayout.columnCount) // 20 - Collection leading/Trailing Margin
        } else {
            cellWidth = UIScreen.main.bounds.width - 20 // 20 - Collection leading/Trailing Margin
        }
        
        
        let labelWidth = cellWidth - 20 // 20 - Label Desc leading/Trailing Margin
        let text = arrayHomeCollectionCellVM?[indexPath.item].homeDataModel?.description
        let descHeight = text?.height(withConstrainedWidth: labelWidth, font: UIFont.systemFont(ofSize: 14.0)) ?? 0
        let cellHeight = descHeight + 80 + 20 + 10 // 80 - Top View Height, 20,10 - margins
        collectionCellSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
}
