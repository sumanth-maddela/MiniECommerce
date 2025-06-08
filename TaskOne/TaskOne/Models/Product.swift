//
//  Product.swift
//  TaskOne
//
//  Created by Sumanth Maddela on 08/06/25.
//

import Foundation
struct Product : Codable {
    var id: Int
    var title : String
    var price : Double
    var description : String
    var category : String
    var image: String
    var rating : ProductRating
}

struct ProductRating: Codable {
    var rate : Double
    var count : Int
}


//{
//  "id": 1,
//  "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
//  "price": 109.95,
//  "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
//  "category": "men's clothing",
//  "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//  "rating": {
//    "rate": 3.9,
//    "count": 120
//  }
