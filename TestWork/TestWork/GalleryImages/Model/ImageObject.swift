//
//  ImageObject.swift
//  TestWork
//
//  Created by Polina on 10.03.2022.
//

import Foundation
import CoreData

// MARK: - ImageObject
@objc (ImageObject)
final class ImageObject: NSManagedObject {
    
    @NSManaged var id: String
    @NSManaged var createdAt: String
    @NSManaged var welcomeDescription: String?
    @NSManaged var urlSmall: String
    @NSManaged var urlRegular: String
    @NSManaged var likes: Int
    @NSManaged var width: Int
    @NSManaged var height: Int

}

