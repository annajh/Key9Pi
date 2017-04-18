//
//  Word+CoreDataProperties.swift
//  
//
//  Created by Michael on 4/18/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var text: String?

}
