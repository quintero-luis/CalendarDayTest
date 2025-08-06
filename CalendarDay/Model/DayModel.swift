//
//  WeekModel.swift
//  CalendarDay
//
//  Created by Luis Quintero on 06/08/25.
//

import Foundation
import SwiftData

@Model
class DayModel {
    var dayNote: String
    var date: Date
    
    init(dayNote: String, date: Date) {
        self.dayNote = dayNote
        self.date = date
    }
}
