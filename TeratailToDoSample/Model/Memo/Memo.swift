//
//  Memo.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation

struct Memo: Codable {
    let id: String // UUID
    let title: String
    let content: String
}
