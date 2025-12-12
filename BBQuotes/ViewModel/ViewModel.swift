//
//  ViewModel.swift
//  BBQuotes
//
//  Created by वैभव उपाध्याय on 19/11/25.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    
    private let fetchService = FetchServices()
    
    var quote: Quote
    var character: MovieCharacter
    var episode: Episode
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(MovieCharacter.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }
    
    func getQuoteData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetchService.fetchQuote(from: show)
            
            character = try await fetchService.fetchCharacter(quote.character)
            
            character.death = try await fetchService.fetchDeath(for: character.name)
            status = .successQuote
        } catch {
            status = .failed(error: error)
        }
    }
    
    func getEpisode(for show: String) async {
        status = .fetching
        
        do {
            if let episode = try await fetchService.fetchEpisode(from: show) {
                self.episode = episode
            }
            status = .successEpisode
        } catch {
            status = .failed(error: error)
        }
    }
}
