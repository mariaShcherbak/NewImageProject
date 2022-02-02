
//
//  FirstPresenter.swift
//  Image
//
//  Created by Tanya on 04.01.2022.
//

import Foundation

protocol FirstViewProtocol: class {
    
    var cellModel: [ForCell] { get set }
    func createModelForCell (urlArrayForCell: [String], completition: @escaping([ForCell]) -> Void)
    func reloadCollectionView()
    
}

protocol FirstPresenterProtocol: class {
    
    init(view: FirstViewProtocol, networkServise: NetworkServiceProtocol)
    func getImageNetwork(searchText: String)
}

class FirstPresenter: FirstPresenterProtocol {

    let view: FirstViewProtocol?
    let networkServise: NetworkServiceProtocol!
    required init(view: FirstViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func getImageNetwork(searchText: String) {
        networkServise.getUrlImage(searchText: searchText, completition: { urlArray in
            self.view?.createModelForCell(urlArrayForCell: urlArray, completition: { (completition: [ForCell]) in
                self.view?.cellModel = completition
                print(self.view?.cellModel.count)
                
                
            })
            self.view?.reloadCollectionView()
        })
        
    }
    
    
}




