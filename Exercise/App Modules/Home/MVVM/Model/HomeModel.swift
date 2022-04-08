//
//  HomeModel.swift
//  Exercise
//
//  Created by Ankush Mahajan on 07/04/22.
//

import Foundation

struct HomeModel : Codable {
    
    let title : String?
    let rows : [HomeDataModel]?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case rows = "rows"
     }

}


struct HomeDataModel : Codable {

    let title : String?
    let description : String?
    let imageHref : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}
