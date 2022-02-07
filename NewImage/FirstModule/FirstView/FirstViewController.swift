//
//  ViewController.swift
//  Image
//
//  Created by Tanya on 04.01.2022.
//
//Надо переделать метод сохранения изображения в папку. Принимать он будет объект типа ForCell, сохранять uiimage sd_set(url) будет под названием, которое будет соответствовать urlCell, и потом сравнивать или удалять надо будет по названию, которое состоит из пути к папке (вынести var в класс) + urlCell при нажатии на изображение.

import UIKit

struct ForCell {
    var urlCell: String
}

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, FirstViewProtocol, UISearchBarDelegate {
    
    var presenter: FirstPresenterProtocol!
    var localDatabaseFirstVC: LocalDatabaseProtocol!
    var cellModel: [ForCell] = []
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
        self.searchBar.delegate = self
        localDatabaseFirstVC = LocalDatabase()
        presenter = FirstPresenter(view: self, networkServise: NetworkService())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.getImageNetwork(searchText: searchBar.text ?? "")
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCollectionViewCell {
            var model = cellModel[indexPath.row]
            if cellModel.isEmpty {
                cell.imageCell.image = UIImage(named: "DefaultImage")
            } else {
                cell.imageCell.sd_setImage(with: URL(string: model.urlCell), completed: nil)
            }
        return cell
            
        }
        return UICollectionViewCell()
    }
    //нажатие на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "Сохранить изображение?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let saveActionHandler = {(action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: nil, message: "Изображение сохранено", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
            //сохранение картинки в галерею
            let cell = self.cellModel[indexPath.row]
            let urlSaveImage = self.localDatabaseFirstVC.saveImageToDocumentDirectory(cell)
            
            // создать и сохранить в userDefaults filepathArray
            self.localDatabaseFirstVC.createFilepathArray(string: urlSaveImage)
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: saveActionHandler)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(saveAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
        
    func updateSearchResults(for searchController: UISearchController) {
        presenter.getImageNetwork(searchText: searchController.searchBar.text!)
    }
    
    func createModelForCell (urlArrayForCell: [String], completition: @escaping([ForCell]) -> Void) {
        var cellModelInFunc: [ForCell] = []
        for i in urlArrayForCell {
            let objectForCell = ForCell(urlCell: i)
            cellModelInFunc.append(objectForCell)
            
        }
        completition(cellModelInFunc)
        }
    
    func reloadCollectionView() {
        collection.reloadData()
    }
    
    
    
}



