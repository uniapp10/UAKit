//
//  HTTP.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/4.
//  Copyright © 2020 ZD. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case failure(Error)
    case success(T)
    var value: T? {
        switch self {
        case .failure:
            return nil
        case .success(let value):
            return value
        }
    }
    func map<R>(_ selector: (T) -> R) -> Result<R> {
        switch self {
        case let .success(value):
            return .success(selector(value))
        case let .failure(error):
            return .failure(error)
        }
    }
    func apply(_ f: (Result<T>) -> Void) -> Void {
        f(self)
    }
}

struct HTTP {
//    static let baseUrl = "https://api.github.com"
    static func request(_ urlString: String, completion: ((Result<Data>)->Void)? = nil) -> Void {
//        guard let url = URL(string: baseUrl+urlString) else {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let error = error {
                    completion?(.failure(error))
                } else if let data = data {
                    completion?(.success(data))
                }
            }
        }
        task.resume()
        // iOS13 废弃， 刘海屏不显示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}
