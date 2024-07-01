//
//  VegetableModel.swift
//  Mainpage
//
//  Created by o9tech on 01/07/2024.
//

import Foundation
import UIKit

struct VegetableModel: Decodable{
    let status: String
    let data: [VegetableData]
}

struct VegetableData: Codable {
    let id: String
    let veg_name: String
    let veg_price: String
    let veg_gram: String
}
