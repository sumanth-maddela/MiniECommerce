//
//  ViewController.swift
//  TaskOne
//
//  Created by Sumanth Maddela on 08/06/25.
//

import UIKit


enum SortOrder {
    case lowToHigh
    case highToLow
}


class HomeViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchButton: UISwitch!
    
    var products = [Product]()
    let urlString = Constants.Urls.apiUrl
    var currentSort: SortOrder = .lowToHigh
    var loaderView: LoaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URL(string: self.urlString)
        view.backgroundColor = Constants.Colors.background
        loaderView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        collectionView.backgroundColor = Constants.Colors.background
        //ADD LOADER
        showLoader()
        NetworkManager.shared.networkCall(request: request) { (result: Result<[Product], Error>) in
            DispatchQueue.main.async {
                self.hideLoader()
                switch result {
                case .success(let products):
                    self.products = products
                    self.collectionView.reloadData()
                    //STOP LOADER
                    print(products)
                case .failure(let error):
                    print(error)
                }
            }
        }
        registerCell()
    }
    
    func registerCell() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    @IBAction func switchBtnAction(_ sender: Any) {
        currentSort = (currentSort == .lowToHigh) ? .highToLow : .lowToHigh
        sortProducts()
    }
    
    func sortProducts() {
        switch currentSort {
        case .lowToHigh:
            products.sort { $0.price < $1.price }
        case .highToLow:
            products.sort { $0.price > $1.price }
        }
        collectionView.reloadData()
    }
    

    func showLoader() {
        if loaderView == nil {
            loaderView = LoaderView.create()
            loaderView?.frame = view.bounds
            view.addSubview(loaderView!)
        }
    }

    func hideLoader() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }


}

extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.clipsToBounds = true
        cell.setupUI(products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let totalSpacing = spacing * 3  // left + right + middle
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: width, height: width + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

