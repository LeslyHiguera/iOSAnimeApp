//
//  AnimeFake.swift
//  iOSAnimeAppTests
//
//  Created by Lesly Higuera on 24/11/22.
//

import Foundation
@testable import iOSAnimeApp

enum AnimeFake {
    
    static var values: [AnimeInfo] {
        [.init(data: dataInfo)]
    }
    
    static var dataInfo: [DataInfo] {
        [.init(images: Image.init(jpg: .init(image_url: "")),
               title: "",
               episodes: 0,
               status: "",
               rating: "",
               score: 0.0,
               type: "",
               duration: "",
               synopsis: ""
               )]
    }
}
