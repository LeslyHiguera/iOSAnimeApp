//
//  AnimesRepositoryMock.swift
//  iOSAnimeAppTests
//
//  Created by Lesly Higuera on 24/11/22.
//

import Foundation
@testable import iOSAnimeApp

class AnimesRepositoryMock: AnimeRepositoryProtocol {
    
    var anime: AnimeInfo?
    
    func showAnime(completionHandler: @escaping (Result<AnimeInfo, Error>) -> Void) {
        if let anime = anime {
            completionHandler(.success(anime))
        }
    }

    func getTopAnime(completionHandler: @escaping (Result<AnimeInfo, Error>) -> Void) {
        if let anime = anime {
            completionHandler(.success(anime))
        }
    }
    
    func getAnime(completionHandler: @escaping (Result<AnimeInfo, Error>) -> Void) {
        if let anime = anime {
            completionHandler(.success(anime))
        }
    }
}
