//
//  Toriko.swift
//  MyOkashi
//
//  Created by 藤治仁 on 2022/06/16.
//

import Foundation

/// お菓子のとりこのJSONのデータ構造
struct Toriko: Codable {
    // JSONのitem内のデータ構造
    struct Item: Codable {
        // お菓子の名称
        let name: String
        // 掲載URL
        let link: URL
        // 画像URL
        let image: URL
        
        enum CodingKeys: String, CodingKey {
            case name
            case link = "url"
            case image
        }
    }
    // 複数要素
    let item: [Item]
    
    enum CodingKeys: String, CodingKey {
        case item
    }
}
