//
//  APILayer.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/21/22.
//

import Foundation

struct URLResult: Decodable {
    let metadata: Metadata
    let results: [School]
    let errors: [APIError]?
}

struct Metadata: Codable {
    let total: Int
    let page: Int
    let per_page: Int
}

struct School: Codable, Equatable {
    let name: String
    let state_fips: Int
    let city: String
    let locale: Int
    
    let size: Int?
    let grad_students: Int?
    let white: Float?
    
    let school_url: String?
    let price_calculator_url: String?

    let degrees_awarded: Int
    let ownership: Int
    
    let pell_grant_rate: Float?
    let academic_year: Int?
    let undergrads_with_pell_grant_or_federal_student_loan: Int?
    
    // CodingKeys used because json names have periods incompatible with swift
    enum CodingKeys: String, CodingKey {
        case name = "school.name"
        case state_fips = "school.state_fips"
        case city = "school.city"
        case locale = "school.locale"
        case size = "2019.student.size"
        case grad_students = "2019.student.grad_students"
        case white = "2019.student.demographics.race_ethnicity.white"
        case school_url = "school.school_url"
        case price_calculator_url = "school.price_calculator_url"
        case degrees_awarded = "school.degrees_awarded.predominant"
        case ownership = "school.ownership"
        case pell_grant_rate = "2019.aid.pell_grant_rate"
        case academic_year = "2019.cost.attendance.academic_year"
        case undergrads_with_pell_grant_or_federal_student_loan = "2019.student.undergrads_with_pell_grant_or_federal_student_loan"
    }
}

extension School {
    // uses keys created above to decode json values
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        state_fips = try values.decode(Int.self, forKey: .state_fips)
        city = try values.decode(String.self, forKey: .city)
        locale = try values.decode(Int.self, forKey: .locale)
        size = try? values.decode(Int.self, forKey: .size)
        grad_students = try? values.decode(Int.self, forKey: .grad_students)
        white = try? values.decode(Float.self, forKey: .white)
        school_url = try? values.decode(String.self, forKey: .school_url)
        price_calculator_url = try? values.decode(String.self, forKey: .price_calculator_url)
        degrees_awarded = try values.decode(Int.self, forKey: .degrees_awarded)
        ownership = try values.decode(Int.self, forKey: .ownership)
        pell_grant_rate = try? values.decode(Float.self, forKey: .pell_grant_rate)
        academic_year = try? values.decode(Int.self, forKey: .academic_year)
        undergrads_with_pell_grant_or_federal_student_loan = try? values.decode(Int.self, forKey: .undergrads_with_pell_grant_or_federal_student_loan)
    }
}

struct APIError: Codable {
    let error: String
    let parameter: String
    let input: String
    let message: String
}

// Default school object used while loading actual schools
let DefaultSchool = School(name: "Loading School", state_fips: 0, city: "N/A", locale: 0, size: nil, grad_students: nil, white: nil, school_url: nil, price_calculator_url: nil, degrees_awarded: 0, ownership: 0, pell_grant_rate: nil, academic_year: nil, undergrads_with_pell_grant_or_federal_student_loan: nil)

func getData(from urlString: String, completion: @escaping (URLResult) -> Void) {
    guard let url = URL(string: urlString) else {
        // if here, url was bad
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            // data non-optional, i.e. it actually exists
            let dataAsString = String(data: data, encoding: .utf8)
            if let dataAsString = dataAsString {
                print(dataAsString)
            }
            
            let decoder = JSONDecoder()
            
            if let verifiedData = try? decoder.decode(URLResult.self, from: data) {
                // successfully made the Swift objects
                completion(verifiedData)
            }
        }
    }.resume()
}
