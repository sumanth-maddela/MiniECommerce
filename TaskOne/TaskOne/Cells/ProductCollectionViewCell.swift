//
//  ProductCollectionViewCell.swift
//  TaskOne
//
//  Created by Sumanth Maddela on 08/06/25.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "ProductCollectionViewCell"
    var imageCache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 12
    }
    

    func downloadImage(_ urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.imageCache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
            
        }.resume()
    }
    
    
    func setupUI(_ product: Product) {
        imageView.image = nil
        downloadImage(product.image) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        titleLabel.text = product.title
        print(product.title)
        descLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        contentView.backgroundColor = Constants.Colors.background
    }
    
}
