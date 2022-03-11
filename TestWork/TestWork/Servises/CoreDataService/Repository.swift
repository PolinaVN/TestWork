//
//  Repository.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import Foundation
import CoreData

final class Repository {
    
    let coreData = CoreDataService.shared
    
    func getImageObjects() -> [ImageObjectResponse] {
        let entityName = String(describing: ImageObject.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        guard let fetchedObject = try? coreData.context.fetch(fetchRequest) as? [ImageObject] else {return []}
        
        var fetchedObjectResponse: [ImageObjectResponse] = []
        
        for imageObject in fetchedObject {
            let imageObjectResponse = ImageObjectResponse(id: imageObject.id, createdAt: imageObject.createdAt, welcomeDescription: imageObject.welcomeDescription, urls: Urls(raw: "", full: "", regular: imageObject.urlRegular, small: "", thumb: "", smallS3: imageObject.urlSmall), likes: imageObject.likes, width: imageObject.width, height: imageObject.height)
            fetchedObjectResponse.append(imageObjectResponse)
        }
        return fetchedObjectResponse
    }
    
    func saveImageObjects(imageObjects: [ImageObjectResponse]) {
        for image in imageObjects {
            let imageObject = ImageObject(context: coreData.context)
            imageObject.id = image.id
            imageObject.createdAt = image.createdAt
            imageObject.welcomeDescription = image.welcomeDescription
            imageObject.urlSmall = image.urls.small
            imageObject.urlRegular = image.urls.regular
            imageObject.likes = image.likes
            imageObject.width = image.width
            imageObject.height = image.height
            coreData.saveContext()
        }
    }
    
    func saveImageData(imageData: Data) {
        let imageDataObject = ImageData(context: coreData.context)
        imageDataObject.data = imageData
        coreData.saveContext()
    }
    
    func getImageData() -> Data {
        let entityName = String(describing: ImageData.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        guard let fetchedObject = try? coreData.context.fetch(fetchRequest) as? ImageData else { return Data() }
        let imagaData = fetchedObject.data
        return imagaData
    }
    
    func deleteAllData() {
        let deleteImageObjects = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "ImageObject"))
        let deleteImagesData = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "ImageData"))
        do {
            try coreData.context.execute(deleteImageObjects)
            try coreData.context.execute(deleteImagesData)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
