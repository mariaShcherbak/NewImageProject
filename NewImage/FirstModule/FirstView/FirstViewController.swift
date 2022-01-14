//
//  ViewController.swift
//  Image
//
//  Created by Tanya on 04.01.2022.
//

import UIKit

struct ForCell {
    var urlCell: String
}

class FirstViewController: UICollectionViewController, FirstViewProtocol, UISearchResultsUpdating {
    
    var savedImage: [UIImage] = []
    var presenter: FirstPresenterProtocol!
    var cellModel: [ForCell] = []
    private let search = UISearchController(searchResultsController: nil)
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ffffff"
        presenter = FirstPresenter(view: self, networkServise: NetworkService())
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search student"
        navigationItem.searchController = search
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        //добавить var savedImage из UserDefaults
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            var model = cellModel[indexPath.row]
            if cellModel.isEmpty {
                cell.imageCell.image = UIImage(named: "DefaultImage")
            } else {
                // cell.imageCell.image = collection.sd_set
                 //sd_set
                 //model.urlCell
            }
            
           
        return cell
            
        }
        return UICollectionViewCell()
    }
    //нажатие на ячейку
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Сохранить фото?", preferredStyle: .alert)
        let yesBtn = UIAlertAction(title: "Yes", style: .default, handler: nil)
        /*{
            var cell = cellModel[indexPath.row]
            var cellImage = cell.urlCell  // добавить метод sd webSet
            savedImage.append(cell.urlCell)
            // добавить сохранение в userdefaults
        }*/
        // добавить вызов метода с сохранением в userdefaults
        let noBtn = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesBtn)
        alert.addAction(noBtn)
         /*
         if let popover = alert.popoverPresentationController {
            popover.sourceView = indexPath
        }
         */
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.getImageNetwork(searchText: searchController.searchBar.text!)
    }
    
    func saveInGalery(image: UIImage) {
        
    }
    
    func createModelForCell (urlArrayForCell: [String], completition: @escaping([ForCell]) -> Void) {
        var cellModelInFunc: [ForCell] = []
        for i in urlArrayForCell {
            let objectForCell = ForCell(urlCell: i)
            cellModelInFunc.append(objectForCell)
            completition(cellModelInFunc)
        }
        print(cellModelInFunc)
        
        }
    
    
}



