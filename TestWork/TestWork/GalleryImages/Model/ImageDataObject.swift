//
//  ImageData.swift
//  TestWork
//
//  Created by Polina on 11.03.2022.
//

import Foundation
import CoreData

// MARK: - ImageData
@objc (ImageData)
final class ImageData: NSManagedObject {

    @NSManaged var data: Data
}
