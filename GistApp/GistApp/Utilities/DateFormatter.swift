//
//  DateFormatter.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import Foundation

final class DateFormatter {
    static func dateForCommits(_ date: Date) -> String {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
