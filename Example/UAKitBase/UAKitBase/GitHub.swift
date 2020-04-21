//
//  GitRepo.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/4.
//  Copyright © 2020 ZD. All rights reserved.
//

import Foundation

struct Repo: Codable {
    var name: String
    var descriptionText: String?
    var starCount: Int
    var urlString: String
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case descriptionText = "description"
        case starCount = "stargazers_count"
        case urlString = "html_url"
    }
}

struct Splash: Codable {
    var url: String
}

enum GitHub {
    static func getRepo(_ url: String, _ completion:@escaping((Result<[Repo]>)-> Void)) {
        HTTP.request(url) { (result) in
            result.map { (data) -> [Repo] in
                let repos = try? JSONDecoder().decode([Repo].self, from: data)
                return repos ?? []
            }
            .apply(completion)
        }
    }
    
    static func getSplash(_ url: String, _ completion:@escaping((Result<Splash>)-> Void)) {
        HTTP.request(url) { (result) in
            result.map { (data) -> Splash in
                let splash = try? JSONDecoder().decode(Splash.self, from: data)
                return splash ?? Splash(url: "")
            }
            .apply(completion)
        }
    }
}
