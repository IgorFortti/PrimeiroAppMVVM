//
//  HomeData.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 20/02/23.
//

import Foundation

// Decodable
// Decodifica = Transforma um json em um objeto.

// Encodable
// Codifica um objeto, ou seja, torna um tipo de dado no swift em Json.

// Codeble
// Ele codifica e descodifica

struct HomeData: Codable {
    var stories: [Stories]?
    var posts: [Posts]?
}
