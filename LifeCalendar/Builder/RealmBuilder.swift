//
//  RealmBuilder.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift
protocol RealmBuilderProtocol {
    func getData<T:Object>(ofType: T.Type) -> [T]?
    func saveDate<T: Object >(date: [T])
    
}
class RealmBuilder: RealmBuilderProtocol{
    let realm = try! Realm()
    
   static let shared = RealmBuilder()
    
     func getData<T:Object>(ofType: T.Type) -> [T]? {
        let saveObjects =  realm.objects(ofType)
        return Array(saveObjects.sorted(byKeyPath: "date", ascending: true))
    }
    
     func saveDate<T: Object >(date: [T]){
        try! realm.write {
            realm.add(date)
        }
    }
}
