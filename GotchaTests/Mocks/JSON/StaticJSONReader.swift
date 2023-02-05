//
//  StaticJSONReader.swift
//  GotchaTests
//
//  Created by Majka on 05/02/2023.
//

import Foundation

struct StaticJSONReader {
    func readJSON(forName name: String) -> Data? {
        let bundle = Bundle(for: MockPokemonApiService.self)
        if let bundlePath = bundle.path(forResource: name,
                                             ofType: "json"),
           let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
        return nil
    }
}
