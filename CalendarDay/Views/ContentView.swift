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
            List(days) { day in
                VStack(alignment: .leading) {
                    HStack {
                        Text(day.date.formatted(.dateTime.weekday())) // Day of the week
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(alignment: .topTrailing)
                            .padding(.top, -32)
                        Spacer()
                        Text(day.date.formatted(date: .abbreviated, time: .omitted)) // Date
                            .foregroundColor(.gray)
                        
                    } // HStack
                    .padding(.vertical, 8)
                    
                    if !day.dayNote.isEmpty {
                                Text(day.dayNote)
                            .font(.body)
                                    
                            } else {
                                Text("Empty Note")
                                    .font(.subheadline)
                                    .italic()
                                    .foregroundColor(.gray)
                            }
                } // 2nd VStack
                .padding()
                .frame(minWidth: 372)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 140)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                .padding(.horizontal, 0)
                .onTapGesture {
                    selectedDay = day
                }
                .listRowSeparator(.hidden) // Hides default lines
            } // List
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.top, 8)
        } // VStack
        .sheet(item: $selectedDay, content: { day in
            EditNoteView(day: day)
        })
    }
}

#Preview {
    ContentView(viewModel: DayListViewModel())
        .modelContainer(for: DayModel.self)
        
}
