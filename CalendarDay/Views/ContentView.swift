//
//  ContentView.swift
//  CalendarDay
//
//  Created by Luis Quintero on 06/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \DayModel.date) var days: [DayModel] // Days sorted by date
    @StateObject var viewModel = DayListViewModel()
    
    @State private var selectedDay: DayModel?
    
    
    var body: some View {
        VStack {
            Button("Generate Current Week") {
                viewModel.generateCurrentWeek(context: context)
            }
            List(days) { day in
                VStack(alignment: .leading) {
                    Text(day.date.formatted(date: .abbreviated, time: .omitted))
                    if !day.dayNote.isEmpty {
                        Text(day.dayNote)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .onTapGesture {
                    selectedDay = day
                }
            }
        }
        .sheet(item: $selectedDay, content: { day in
            EditNoteView(day: day)
        })
        .padding()
    }
}

#Preview {
    ContentView(viewModel: DayListViewModel())
        .modelContainer(for: DayModel.self)
        
}
