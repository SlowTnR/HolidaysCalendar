//
//  HolidayRequest.swift
//  HolidaysCalendar
//
//  Created by Ilja Patrushev on 8.12.2020.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
    
}


struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = Config.apiKey
    
    init(countryCode: String){
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        let resourseString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourseString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping (Result<[HolidayDetail], HolidayError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }
            catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
