//
//  HistoryManager.swift
//  Translator
//
//  Created by Dastan Mambetaliev on 26/3/21.
//

import Foundation
import RealmSwift

class HistoryManager {
    var database: Realm
    static let sharedInstance = HistoryManager()
    
    init() {
        database = try! Realm()
    }
    
    func getDataFromData() ->  Results<TranslatedItems> {
        let results: Results<TranslatedItems> = database.objects(TranslatedItems.self)
        return results
    }
    
    func addData(object: TranslatedItems)   {
        try! database.write {
            database.add(object)
        }
        deleteOldItems()
    }
    
    func deleteOldItems() {
        let result = getDataFromData()
        while result.count > 10 {
            try!   database.write {
                database.delete(result.sorted(byKeyPath: "date", ascending: false).last!)
            }
        }
    }
    
}
