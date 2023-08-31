//
//  services.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//


import Foundation

protocol ItemListServiceProtocol {
    func getItemList(completion: @escaping (_ success: Bool, _ results: HomeDataResponse?, _ error: String?) -> ())
    func getImageData(imageUrl:String) -> Data
}

class ItemListService: ItemListServiceProtocol {
    let API_FETCH_ITEM_LIST = "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0"
    
    func getItemList(completion: @escaping (Bool, HomeDataResponse?, String?) -> ()) {
        HttpRequestHelper().GET(url: API_FETCH_ITEM_LIST, params: ["":""], httpHeader:  ["":""]) { success, data in
            if success {
                do {
                    let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    if let resultdata = jsonString!.data(using: String.Encoding.utf16.rawValue) {
                        let model = try JSONDecoder().decode(HomeDataResponse.self, from: resultdata)
                        completion(true, model, nil)
                    }
                } catch {
                    completion(false, nil, "Error: Trying to parse items to model")
                }
            } else {
                completion(false, nil, "Error: items GET Request failed")
            }
        }
    }
    
    
    func getImageData(imageUrl: String) -> Data {
        var dataResponse = Data()
        HttpRequestHelper().GET(url: imageUrl, params: [:], httpHeader: [:]){
            success,data in
            if success{
                dataResponse = data ?? dataResponse
            }
        }
        return dataResponse
    }
}
