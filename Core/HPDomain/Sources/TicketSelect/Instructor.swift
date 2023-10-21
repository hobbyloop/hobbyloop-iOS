//
//  Instructor.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/09/22.
//

import Foundation


public struct Instructor: Decodable {
    public let status: Int
    public let instructorInfo: [InstructorInfo]
    
    public enum CodingKeys: String, CodingKey {
        case status
        case instructorInfo = "data"
        
        
    }
    
    
}


public struct InstructorInfo: Decodable {
    public let instructorName: String
    public let instructorImageURL: String
    public let lessons: [InstructorLessonInfo]
    
    
    public enum CodingKeys: String, CodingKey {
        case instructorName = "instructorName"
        case instructorImageURL = "instructorRepImageUrl"
        case lessons
        
    }
    
}


public struct InstructorLessonInfo: Decodable {
    public let startDate: String
    public let endDate: String
    public let lessonName: String?
    public let lessonCapacity: Int
    public let lessonEmptySpace: Int
    public let lessonStatus: String
    public let difficulty: String
    
    
    public enum CodingKeys: String, CodingKey {
        case startDate = "start"
        case endDate = "end"
        case lessonName = "lessonName"
        case lessonCapacity
        case lessonEmptySpace
        case lessonStatus
        case difficulty
        
        
        
    }
    
}
