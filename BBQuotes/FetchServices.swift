//
//  FetchServices.swift
//  BBQuotes
//
//  Created by वैभव उपाध्याय on 05/11/25.
//
import Foundation

struct FetchServices {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    /// https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production",
                                                                    value: show)])
        
        // fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw FetchError.badResponse
        }
        
        // Deocde data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return Quote
        return quote
    }
    
    func fetchCharacter(_ character: String) async throws -> MovieCharacter {
        // Build URL
        let fetchURL = baseURL.appending(path: "characters").appending(queryItems: [URLQueryItem(name: "name", value: character)])
        
        // Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Hnadle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([MovieCharacter].self, from: data)
        
        // return response
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        // Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Hnadle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        // return response
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeURL = baseURL.appending(path: "episodes")
        
        /// Fetch Data
        let (data, response) = try await URLSession.shared.data(from: episodeURL)
        
        /// Handle respnse
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
}
