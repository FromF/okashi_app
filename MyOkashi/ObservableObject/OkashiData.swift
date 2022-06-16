//
//  OkashiData.swift
//  OkashiData
//
//  Created by Swift-Beginners.
//

import Foundation
import SwiftUI

// お菓子データ検索用クラス
class OkashiData: ObservableObject {
    // お菓子のリスト（Identifiableプロトコル）
    @Published var okashiList: [OkashiItem] = []
    
    // Web API検索用メソッド　第一引数：keyword 検索したいワード
    func searchOkashi(keyword: String) {
        // デバッグエリアに出力
        print("検索キーワード:\(keyword)")
        
        // Taskは非同期で処理を実行できる
        Task {
            await search(keyword)
        }
    }
    
    // @Publishedの変数を更新するときはメインスレッドで更新する必要があるため @MainActorを追加する
    @MainActor private func search(_ keyword: String) async {
        // お菓子の検索キーワードをURLエンコードして
        // リクエストURLの組み立てする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ,
              let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        
        print("リクエストするURL:\(req_url)")
        
        do {
            // リクエストURLからダウンロード
            let (data , _) = try await URLSession.shared.data(from: req_url)
            
            // JSONDecoderのインスタンス取得
            let decoder = JSONDecoder()
            // 受け取ったJSONデータをパース（解析）して格納
            let json = try decoder.decode(Toriko.self, from: data)
            
            // print(json)
            
            // お菓子の情報が取得できているか確認
            let items = json.item
            // お菓子のリストを初期化
            okashiList.removeAll()
            
            // 取得しているお菓子の数だけ処理
            for item in items {
                // 1つのお菓子を構造体でまとめて管理
                let okashi = OkashiItem(name: item.name, link: item.link, image: item.image)
                // お菓子の配列へ追加
                okashiList.append(okashi)
                // okashiList <-これは文字列
            }
            
            print("okashiListの中身:\(okashiList)")
        } catch {
            // エラー処理
            print("エラーが出ました")
        }
    }
}
