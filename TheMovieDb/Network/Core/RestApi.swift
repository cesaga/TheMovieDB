//
//  RestApi.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

class RestApi {
    
    func request<T: Decodable>(endpoint: EndpointDefinition) async throws -> T {
        
        let url = "\(endpoint.baseURL)/\(endpoint.path)"
        let defaultParams = getDefaultQueryParams()
        var queryParams = endpoint.queryParams
        queryParams.merge(defaultParams) {(current,_) in current}
        let finalUrl = makeURL(url: url, queryParams: queryParams)
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(finalUrl, method: endpoint.method)
                .responseData { response in
                    if let data = response.data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let model = try jsonDecoder.decode(T.self, from: data)
                            continuation.resume(with: .success(model))
                        } catch {
                            continuation.resume(with: .failure(error))
                        }
                    }
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    }
                }
        }
    }
    
    private func getDefaultQueryParams() -> [String: String] {
        return Constants.apiKey
    }
    
    private func makeURL(url: String, queryParams: [String: String]) -> String {
        guard var urlComps = URLComponents(string: url) else {
            return url
        }
        
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in queryParams {
            let param = URLQueryItem(name: key, value: value)
            queryItems.append(param)
        }
        
        urlComps.queryItems = queryItems
        
        guard let result = urlComps.url?.absoluteString else {
            return url
        }
        return result
    }
}
