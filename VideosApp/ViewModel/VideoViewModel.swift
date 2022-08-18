//
//  VideoViewModel.swift
//  VideosApp
//
//  Created by Adil Özdemir on 17.08.2022.
//

import Foundation

enum Query: String, CaseIterable {
    case nature, animals, people, ocean, food
}

class VideoViewModel: ObservableObject {
    @Published private(set) var videos: [Video] = []
    @Published var selectedCategory: Query = .nature {
        didSet {
            Task.init {
                await findVideos(topic: selectedCategory)
            }
        }
    }

    init() {
        Task.init {
            await findVideos(topic: selectedCategory)
        }
    }

    func findVideos(topic: Query) async {
        let rawUrl = "https://api.pexels.com/videos/search?query=\(topic)&per_page=10&orientation=portrait"
        let apiKey = "563492ad6f91700001000001cdf0b90b9f1c433fa6fac22a09b74715"
        do {
            guard let url = URL(string: rawUrl) else { fatalError("Missing URL") }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(apiKey, forHTTPHeaderField: "Authorization")

            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("========>\(String(describing: (response as? HTTPURLResponse)?.statusCode))")
//                fatalError("There was an error while fetching video from Pexels")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let responseBody = try decoder.decode(ResponseBody.self, from: data)
            DispatchQueue.main.async {
                self.videos = []
                self.videos = responseBody.videos
            }
           
        } catch {
            print("There was an error while fetching video from Pexels:  {\(error)}")
        }
    }
}
