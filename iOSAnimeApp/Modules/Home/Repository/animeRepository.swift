//
//  animeRepository.swift
//  iOSAnimeApp
//
//  Created by Lesly Higuera on 12/01/23.
//

import Foundation
import UIKit
import CoreData


protocol AnimeRepositoryProtocol {
    func getAnime(completionHandler: @escaping GenericCompletionHandler<Result<AnimeInfo, Error>>)
    func getTopAnime(completionHandler: @escaping GenericCompletionHandler<Result<AnimeInfo, Error>>)
    func showAnime(completionHandler: @escaping GenericCompletionHandler<Result<AnimeInfo, Error>>)
}

class AnimeRepository: AnimeRepositoryProtocol {
    
    func getTopAnime(completionHandler: @escaping (Result<AnimeInfo, Error>) -> Void) {
        APIManager.request(with: APIConstants.apiTopUrl, completionHandler: completionHandler)
    }
    
    func getAnime(completionHandler: @escaping (Result<AnimeInfo, Error>) -> Void) {
        let localAnimes = self.getAnimes()
        if localAnimes.count > 0  {
            completionHandler(.success(AnimeInfo(data: localAnimes)))
            return
        }
        
        APIManager.request(with: APIConstants.apiUrl) { (result: Result<AnimeInfo, Error>) in
            switch result {
            case .success(let success):
                self.deleteAnime()
                self.saveAnime(success)
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
    
    func showAnime(completionHandler: @escaping (Result<AnimeInfo, Error>) -> Void) {
        let localAnimes = self.getAnimes()
        if localAnimes.count > 0  {
            completionHandler(.success(AnimeInfo(data: localAnimes)))
            return
        }
        
        APIManager.request(with: APIConstants.apiUrl) { (result: Result<AnimeInfo, Error>) in
            switch result {
            case .success(let success):
                self.deleteAnime()
                self.saveAnime(success)
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
    
    func saveAnime(_ animes: AnimeInfo) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        animes.data?.forEach { anime in
            let animesCoreData = DataCD(context: appDelegate.persistentContainer.viewContext)
            animesCoreData.image = anime.images?.jpg?.image_url
            animesCoreData.tittle = anime.title
            animesCoreData.episodes = Int64(anime.episodes ?? 0)
            animesCoreData.rating = anime.rating
            animesCoreData.score = Double(anime.score!)
            animesCoreData.type = anime.type
            animesCoreData.duration = anime.duration
            animesCoreData.synopsis = anime.synopsis
            appDelegate.saveContext()
        }
    }
    
    private func getAnimes() -> [DataInfo] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var animeInfo: [DataInfo] = []
        do {
            let fetchRequest: NSFetchRequest<DataCD> = DataCD.fetchRequest()
            let coreDataAnimes = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            coreDataAnimes.forEach {
                let dataCD = DataInfo(images: Image(jpg: Jpg(image_url: $0.image)),
                                      title: $0.tittle,
                                      episodes: Int($0.episodes),
                                      status: $0.status,
                                      rating: $0.rating,
                                      score: $0.score,
                                      type: $0.type,
                                      duration: $0.duration,
                                      synopsis: $0.synopsis)
                animeInfo.append(dataCD)
            }
        } catch {
            print(error.localizedDescription)
        }
        return animeInfo
    }
    
    private func deleteAnime() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        do {
            let fetchRequest: NSFetchRequest<DataCD> = DataCD.fetchRequest()
            let coreDataAnimes = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            coreDataAnimes.forEach {
                appDelegate.persistentContainer.viewContext.delete($0)
            }
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
