//
//  NetworkService.swift
//  Image
//
//  Created by Tanya on 04.01.2022.
//

import Foundation
import Alamofire
import SDWebImage


protocol NetworkServiceProtocol {
    
    func getUrlImage(searchText: String, completition: @escaping([String]) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getUrlImage(searchText: String, completition: @escaping([String]) -> Void) {
    let headers : HTTPHeaders = ["x-rapidapi-host":"contextualwebsearch-websearch-v1.p.rapidapi.com",
                                 "x-rapidapi-key": "429d1f67f5msh6e682b2630b26fap1d379ejsn76891854765a"]
        var searchTextInUrl = searchText
    AF.request("https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/ImageSearchAPI?q=" + searchText + "&pageNumber=1&pageSize=7&autoCorrect=true", parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil).response {
        (responseData) in
        guard let data = responseData.data else {return}
        do {
            print()
            let imageGet = try JSONDecoder().decode(RandomImage.self, from: data)
            var urlArray: [String] = []
            for i in imageGet.value {
                let url = i.url
                urlArray.append(url)
            }
            completition(urlArray)
        } catch {
            print("error")
        }
    }
        
    }
}

