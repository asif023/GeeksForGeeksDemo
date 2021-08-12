//
//  Modals.swift
//  GeeksforGeeks
//
//  Created by MAC on 11/08/21.
//

import Foundation
class EOItemModal: Codable {
    var title:String?
    var pubDate:String?
    var link:String?
    var guid:String?
    var author:String?
    var thumbnail:String?
    var description:String?
    var content:String?
    var categories:[String?]
    var enclosure:EnclosureModal?
}
class EnclosureModal: Codable {
    var link: String?
    var type:String?
    var thumbnail: String?
}
