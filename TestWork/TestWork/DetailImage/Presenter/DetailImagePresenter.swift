//
//  DetailImagePresenter.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import Foundation

protocol DetailImageView: AnyObject {
    func reload(data:Data)
}

final class DetailImagePresenter {
    
    // MARK: - Public Properties
    var width = Int()
    var height = Int()
    var title = String()
    
    // MARK: - Private Properties
    private var imageResponse: ImageObjectResponse?
    private weak var view: DetailImageView?
    private var createdAt = String()
    private var welcomeDescription = String()
    private var url = String()
    private var likes = Int()
    private var imageAPIService = ImageAPIService()
    private let repository = Repository()
    
    // MARK: - Life Cycle
    init(view: DetailImageView, image: ImageObjectResponse) {
        self.view = view
        self.imageResponse = image
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        getDetailAboutImage()
        titleDetailAboutImage()
        convertPxToPt()
    }
    
    private func getDetailAboutImage() {
        likes = imageResponse?.likes ?? 0
        width = imageResponse?.width ?? 0
        height = imageResponse?.height ?? 0
        createdAt = imageResponse?.createdAt ?? ""
        url = imageResponse?.urls.regular ?? ""
        welcomeDescription = imageResponse?.welcomeDescription ?? ""
    }
    
    private func convertPxToPt() {
        width = width / 13
        height = height / 13
    }
    
    private func titleDetailAboutImage() {
        let dateTitle = dateFormatter()
        if welcomeDescription == "" {
            title = "Нравится: \(likes) 👍\n\nЗагружено: \(dateTitle)"
        } else {
            title = "Likes: \(likes) 👍\n\n\(welcomeDescription) \n\nЗагружено: \(dateTitle)"
        }
    }
    
    private func dateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: createdAt)!
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let formatDateStr = dateFormatter.string(from: date)
        return formatDateStr
    }
}

