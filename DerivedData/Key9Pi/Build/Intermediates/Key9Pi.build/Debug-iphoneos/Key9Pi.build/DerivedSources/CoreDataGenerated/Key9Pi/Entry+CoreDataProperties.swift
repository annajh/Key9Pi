//
//  Entry+CoreDataProperties.swift
//  
//
//  Created by Michael on 2/16/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry");
    }

    @NSManaged public var word: String?

}
