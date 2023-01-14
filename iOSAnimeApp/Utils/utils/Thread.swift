//
//  Thread.swift
//  iOSAnimeApp
//
//  Created by Lesly Higuera on 13/01/23.
//

import Foundation

enum Thread {
    static func main(_ block: @escaping () -> Void?) {
        DispatchQueue.main.async {
            block()
        }
    }
}
