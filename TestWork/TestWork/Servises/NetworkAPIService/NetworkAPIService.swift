//
//  NetworkAPIService.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import Foundation

final class NetworkAPIService {
    
    // MARK: - Private Properties
    private var apiKEY = "Wcpm1SWjB6iChu3IkUj8aQdxRN7Cdk4nl5Gx9nRHULo"
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos"
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "client_id", value: apiKEY)
        ]
        return components.url
    }
    
    // MARK: - Public Methods
    func getImageObjectsResponse(completionHandler: @escaping (Result<[ImageObjectResponse], Error>) -> Void ) {
        guard let urlRequest = url else {return}
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {return}
            do {
                let imageObjectsResponse = try JSONDecoder().decode([ImageObjectResponse].self, from: data)
                completionHandler(.success(imageObjectsResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}


