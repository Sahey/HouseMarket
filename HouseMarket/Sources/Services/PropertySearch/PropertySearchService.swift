//
//  PropertySearchService.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Foundation

protocol PropertySearchServiceProtocol {
    func fetch(request: PropertySearch.Request, completion: @escaping (Result<PropertySearch.Response, Error>) -> Void)
}

final class PropertySearchServiceMock: PropertySearchServiceProtocol {
    var shouldSimulateFailure = false
    func fetch(request: PropertySearch.Request, completion: @escaping (Result<PropertySearch.Response, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if self.shouldSimulateFailure {
                let error = NSError(domain: "123", code: 123, userInfo: nil)
                completion(.failure(error))
                return
            }
            let url = Bundle.main.url(forResource: "PropertySearch", withExtension: "json")!
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(PropertySearch.Response.self, from: jsonData)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
