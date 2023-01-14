//
//  AnimeViewModel.swift
//  iOSAnimeApp
//
//  Created by Lesly Higuera on 13/01/23.
//

import Foundation

class AnimeViewModel {
    
    // MARK: - Internal Properties
    
    var error: GenericCompletionHandler<String> = { _ in }
    var success: CompletionHandler = {}
    var animes: [DataInfo] = []
    var topAnimes: [DataInfo] = []
    var showAnime: [DataInfo] = []
    
    // MARK: - Private Properties
    
    private var repository: AnimeRepositoryProtocol!
    
    // MARK: - Initializers
    
    init(repository: AnimeRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Internal Methods
    
    func getTopAnime() {
        repository.getTopAnime { result in
            switch result {
            case .success(let animes):
                self.topAnimes = animes.data ?? []
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
    
    func getAnime() {
        repository.getAnime { result in
            switch result {
            case .success(let animes):
                self.animes = animes.data ?? []
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
    
    func showAnimes() {
        repository.showAnime { result in
            switch result {
            case .success(let animes):
                self.showAnime = animes.data ?? []
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }

}
