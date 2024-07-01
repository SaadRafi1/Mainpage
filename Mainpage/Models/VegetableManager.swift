//
//  VegetableManager.swift
//  Mainpage
//
//  Created by o9tech on 01/07/2024.
//

import Foundation
import UIKit

struct VegetableManager {

    func fetchdata(completion: @escaping(VegetableModel) -> Void){
        guard let url = URL(string: "https://c331f869c7d7489a935a13c5466751d1.api.mockbin.io/") else { return }
        let data = URLSession.shared.dataTask(with: url){(data,_,error) in
            if let error = error {
                print("error fetching data: \(error.localizedDescription)")
            }
            guard let jsondata = data else{return}
            let decoder = JSONDecoder()
            do{
                let decodeddata = try decoder.decode(VegetableModel.self, from: jsondata)
                completion(decodeddata)
            }
            catch{
                print("Error decoding data ")
            }
        }
        data.resume()
    }
}
