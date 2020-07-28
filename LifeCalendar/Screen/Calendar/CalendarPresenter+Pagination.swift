//
//  CalendarPresenter+Pagination.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 27.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
extension CalendarPresenter{
    func getPaginationWeeks(pagination: Int, isFirst: Bool, isTopScroll: Bool?){
        if isFirst{
                   let myBirthday = UserDefaults.standard.object(forKey: "myBirthday") as! Date
                   let daysOfLifeIndex = Date().weeks(from: myBirthday)
                   guard let currentDayIndex = self.tempWeeks.first(where: {$0.index == daysOfLifeIndex})?.index else {return}
                   let chunc = Array(self.tempWeeks[currentDayIndex-pagination...currentDayIndex+pagination])
                   chunc.forEach({
                       weeks.append(self.getCurrentDate(date: $0, dateType: .week))
                   })
               }else{
                   if isTopScroll ?? false{
                       self.insertNewWeeks(pagination: pagination)
                   }else{
                       self.appendNewWeeks(pagination: pagination)
                   }
               }
    }
    func appendNewWeeks(pagination:Int){
        let tempIndex = weeks.last!.index + pagination
               if self.tempWeeks.indices.contains(tempIndex) {
                   let chunc = Array(self.tempWeeks[weeks.last!.index+1...tempIndex])
                   chunc.forEach({
                       weeks.append(self.getCurrentDate(date: $0, dateType: .week))
                   })
                   self.presentingData = weeks
                   self.view?.addPaggination()
               }else{
                   print("Error")
               }
    }
    func insertNewWeeks(pagination: Int){
           let tempIndex = weeks.first!.index - pagination
           if self.tempWeeks.indices.contains(tempIndex) {
               let chunc = Array(self.tempWeeks[tempIndex...weeks.first!.index-1])
               chunc.forEach({
                   weeks.insert(self.getCurrentDate(date: $0, dateType: .week), at: 0)
               })
               self.presentingData = weeks
               self.view?.addPaggination()
               
           }else{
               print("Error")
           }
       }
    
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
            self.view?.addPaggination()
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
            self.view?.addPaggination()
            
        }else{
            print("Error")
        }
    }

}
