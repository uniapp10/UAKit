//
//  NSObject(Model).swift
//  SimilarPro
//
//  Created by ZD on 2020/2/25.
//  Copyright © 2020 ZD. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// 字典2模型 模型遵守 Codable 协议
    func toModel<T: Codable>(model: T.Type, dict: [String:Any]) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
    
    func toModel<T: Codable>(model: T.Type, dictArray: [[String:Any]]) -> [T]? {
        let res = dictArray.map { (dict) -> T in
            return self.toModel(model: model.self, dict: dict)!
        }
        return res
    }
    
    /// data2模型数组 模型遵守 Codable 协议
    func toModel<T: Codable>(model: T.Type, json: Data) -> [T]? {
        guard let jsonObj = try? JSONSerialization.jsonObject(with: json, options: .fragmentsAllowed) else {
            return nil
        }
        if let dict = jsonObj as? [String:Any],
           let model = toModel(model: model.self, dict: dict) {
            return [model]
        }
        if let dictArray = jsonObj as? [[String:Any]] {
            let res = dictArray.map { (dict) -> T in
                return self.toModel(model: model.self, dict: dict)!
            }
            return res
        }
        return nil
    }
    
    func toModel<T: Codable>(model: T.Type, json: String) -> [T]? {
        guard let data = json.data(using: .utf8) else {
            return nil
        }
        return toModel(model: model.self, json: data)
    }
}
