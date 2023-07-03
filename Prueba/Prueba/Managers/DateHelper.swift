//
//  DateManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import Foundation

class DateHelper {

    static func convertStringToDate<T: DateFormatterConvertible>(dateString: String, format: T) -> Date? {
        let formatter = format.dateFormatter()
        return formatter.date(from: dateString)
    }

    static func convertDateToString<T: DateFormatterConvertible>(date: Date, format: T) -> String {
        let formatter = format.dateFormatter()
        return formatter.string(from: date)
    }
}

protocol DateFormatterConvertible {
    func dateFormatter() -> DateFormatter
}

extension String: DateFormatterConvertible {
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale =  Locale(identifier: "en_US")
        formatter.dateFormat = self
        return formatter
    }
}

extension Date: DateFormatterConvertible {
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
}
