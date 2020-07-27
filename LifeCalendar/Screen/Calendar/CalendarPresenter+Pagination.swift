//
//  CalendarPresenter+Pagination.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 27.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
extension CalendarPresenter{
    
    func getPaginationDays(pagination: Int, isFirst: Bool, isTopScroll: Bool?){
        if isFirst{
            let myBirthday = UserDefaults.standard.object(forKey: "myBirthday") as! Date
            let daysOfLifeIndex = Date().days(from: myBirthday)
            guard let currentDayIndex = self.tempDays.first(where: {$0.index == daysOfLifeIndex})?.index else {return}
            let chunc = Array(self.tempDays[currentDayIndex-pagination...currentDayIndex+pagination])
            chunc.forEach({
                days.append(self.getCurrentDate(date: $0, dateType: .day))
            })
        }else{
            if isTopScroll ?? false{
                self.insertNewDays(pagination: pagination)
            }else{
                self.appendNewDays(pagination: pagination)
            }
        }
    }
    func appendNewDays(pagination:Int){
        let tempIndex = days.last!.index + pagination
        if self.tempDays.indices.contains(tempIndex) {
            let chunc = Array(self.tempDays[days.last!.index+1...tempIndex])
            chunc.forEach({
                days.append(self.getCurrentDate(date: $0, dateType: .day))
            })
            self.presentingData = days
            self.view?.addPagginationDays()
        }else{
            print("Error")
        }
    }
    func insertNewDays(pagination: Int){
        let tempIndex = days.first!.index - pagination
        if self.tempDays.indices.contains(tempIndex) {
            let chunc = Array(self.tempDays[tempIndex...days.first!.index-1])
            chunc.forEach({
                days.insert(self.getCurrentDate(date: $0, dateType: .day), at: 0)
            })
            self.presentingData = days
            self.view?.addPagginationDays()
            
        }else{
            print("Error")
        }
    }

}
