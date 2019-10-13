//
//  HotpepperError.swift
//  Gourmet
//
//  Created by Susumu Hoshikawa on 2019/10/12.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation

enum HotpepperError: Error {
    case parsing(description: String)
    case network(description: String)
}
