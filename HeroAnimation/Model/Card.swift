//
//  Card.swift
//  HeroAnimation
//
//  Created by Simec Sys Ltd. on 5/12/20.
//

import Foundation

struct Card: Identifiable {
    var id: Int
    var image: String
    var title: String
    var details: String
    var expand: Bool
}
