// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseBody = try? newJSONDecoder().decode(ResponseBody.self, from: jsonData)

import Foundation

// MARK: - ResponseBody

struct ResponseBody: Decodable {
    let page, perPage, totalResults: Int
    let url: String
    let videos: [Video]
}

// MARK: - Video

struct Video: Identifiable, Decodable {
    let id: Int
    let image: String
    let duration: Int
    let user: User
    let videoFiles: [VideoFile]
}

// MARK: - User

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let url: String
}

// MARK: - VideoFile

struct VideoFile:Identifiable, Decodable  {
    let id: Int
    let quality, fileType: String
    let link: String


}

