//
//  DayListViewModel.swift
//  CalendarDay
//
//  Created by Luis Quintero on 06/08/25.
//

import Foundation
import SwiftData

class DayListViewModel: ObservableObject {
    
    /// Finds monday of the current week, creates an array of 7 DayModel, saves the array in self.days
    func generateCurrentWeek(context: ModelContext) {
        // Get current week interval of the year
        guard let currentWeek = Calendar.current.dateInterval(of: .weekOfYear, for: Date()) else {
            return
        }
        
        var startOfWeek = currentWeek.start
        
        if Calendar.current.firstWeekday == 1 {
            // If the fisrt day is Sunday, we add 1 to that day, so it begins in Monday
            startOfWeek = Calendar.current.date(byAdding: .day, value: 1, to: startOfWeek)!
        } // startOfWeek is now Monday
        
        for i in 0..<7 {
            let currentDate = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!
            
            
            /// FetchDescriptor<DayModel>
            /// This is an instruction that defines how to search for data in the database managed by SwiftData.
            /// Basically, you tell it: "I want to search for DayModel objects that meet a certain condition, and I want the result sorted in this or that way."
            let fetchDescriptor = FetchDescriptor<DayModel>(
                predicate: #Predicate { $0.date == currentDate }, // #Predicate -> All DayModel that has a date = currentDate
                sortBy: [] // How to order results, but as we only use current week, we dont need it
            )
            // Check if there´s already a saved DayModel for this date to avoid Duplicates
            let existing = try? context.fetch(fetchDescriptor) /// context.fetch(...) may throw an error if the query fails. We use try? so if it is error, existing will be nil
            // doesNotExist is -> Context is nil or is empty
            let doesNotExist = (existing == nil) || (existing?.isEmpty == true)
            
            if doesNotExist {
                let dayModel = DayModel(dayNote: "", date: currentDate)
                context.insert(dayModel)
            }
        }
    }
}
