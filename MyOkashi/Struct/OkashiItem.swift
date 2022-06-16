//
//  OkashiItem.swift
//  MyOkashi
//
//  Created by 藤治仁 on 2022/06/16.
//

import Foundation

// Identifiableプロトコルを利用して、お菓子の情報をまとめる構造体
struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: URL
}
