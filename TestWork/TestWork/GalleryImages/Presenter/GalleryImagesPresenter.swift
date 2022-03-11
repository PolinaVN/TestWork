//
//  GalleryImagesPresenter.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import Foundation

protocol GalleryImagesView: AnyObject {
    func reloadCollectionView()
}

final class GalleryImagesPresenter {
    
    // MARK: - Public Properties
    var imagesResponse: [ImageObjectResponse] = []
    
    // MARK: - Private Properties
    private weak var view: GalleryImagesView?
    private let networkAPIService = NetworkAPIService()
    private let imageAPIService = ImageAPIService()
    private let repository = Repository()
    
    // MARK: - Life Cycle
    init(view: GalleryImagesView) {
        self.view = view
        fetchImagesResponse()
    }
    
    // MARK: - Public Methods
    func getImageData(index: Int, completion: @escaping (Data)->()) {
        let imageDataCoreData = repository.getImageData()
        guard imageDataCoreData.isEmpty == true else {
            completion(imageDataCoreData)
            return
        }
        let urlString = imagesResponse[index].urls.smallS3
        imageAPIService.getImageData(urlString: urlString, completionHandler: { [weak self] result in
            switch result {
            case .success(let dataImage):
                self?.repository.deleteAllData()
                self?.repository.saveImageData(imageData: dataImage)
                completion(dataImage)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Private Methods
    private func fetchImagesResponse() {
        let imagesCoreData = repository.getImageObjects()
        guard imagesCoreData.isEmpty == true else {
            self.imagesResponse = imagesCoreData
            return
        }
        networkAPIService.getImageObjectsResponse { [weak self] result in
            switch result {
            case .success(let imageResponse):
                self?.imagesResponse = imageResponse
                self?.repository.deleteAllData()
                self?.repository.saveImageObjects(imageObjects: imageResponse)
                DispatchQueue.main.async {
                    self?.view?.reloadCollectionView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

