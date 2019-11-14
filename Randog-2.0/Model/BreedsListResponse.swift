//
//  BreedsListResponse.swift
//  Randog-2.0
//
//  Created by Michael Haviv on 11/14/19.
//  Copyright © 2019 Michael Haviv. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String:[String]]
}
