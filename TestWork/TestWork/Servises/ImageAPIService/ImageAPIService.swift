//
//  ImageAPIService.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import UIKit

final class ImageAPIService {
    
    // MARK: - Public Methods
    func getImageData(urlString: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completionHandler(.success(data))
        }
        task.resume()
    }
}


