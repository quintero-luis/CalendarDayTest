//
//  CalendarDayApp.swift
//  CalendarDay
//
//  Created by Luis Quintero on 06/08/25.
//

import SwiftUI

@main
struct CalendarDayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: DayListViewModel())
                .modelContainer(for: DayModel.self) // Using SwiftData to save models of type DayModel
        }
    }
}
