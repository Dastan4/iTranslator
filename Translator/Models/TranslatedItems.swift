//
//  File.swift
//  Translator
//
//  Created by Dastan Mambetaliev on 26/3/21.
//

import Foundation
import RealmSwift

class TranslatedItems: Object {
    @objc dynamic var russianText: String = ""
    @objc dynamic var englishText: String = ""
    @objc dynamic var date: Date = Date()
}

