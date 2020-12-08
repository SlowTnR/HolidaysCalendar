//
//  Holiday.swift
//  HolidaysCalendar
//
//  Created by Ilja Patrushev on 8.12.2020.
//

import Foundation

struct HolidayResponse: Codable {
    let response: Holidays
}

struct Holidays: Codable {
    let holidays: [HolidayDetail]
}

struct HolidayDetail: Codable {
    let name: String
    let date:DateInfo
}

struct DateInfo: Codable {
    let iso: String
    
}


