//
//  EditNoteView.swift
//  CalendarDay
//
//  Created by Luis Quintero on 07/08/25.
//

import SwiftUI

struct EditNoteView: View {
    @Bindable var day: DayModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Write a note...", text: $day.dayNote)
            }
            .navigationTitle(day.date.formatted(date: .abbreviated, time: .omitted))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
