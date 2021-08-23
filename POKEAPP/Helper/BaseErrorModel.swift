//
//  BaseErrorModel.swift
//  POKEAPP
//
//  Created by Phincon on 21/08/21.
//

import Foundation

struct BaseErrorModel: Codable {
    let status_message: String?
    let status_code: Int?
}
