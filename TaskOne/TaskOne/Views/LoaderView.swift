//
//  LoaderView.swift
//  TaskOne
//
//  Created by Sumanth Maddela on 09/06/25.
//

import UIKit

class LoaderView: UIView {
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
         super.awakeFromNib()
         activityIndicator.startAnimating()
     }

     static func create() -> LoaderView {
         let nib = UINib(nibName: "LoaderView", bundle: nil)
         return nib.instantiate(withOwner: nil, options: nil)[0] as! LoaderView
     }
    
}
