//
//  ConvData.swift
//  Conv-Hub
//
//  Created by fox on 2022/7/22.
//

import Foundation
import Foundation

struct ConvData {
    var lastUpdateTime: String = ""     // 更新时间
    var localConfirm: Int = 0           // 本土现有疫情
    var nowConfirm: Int = 0             // 现有确诊
    var confirm: Int = 0                // 累计确诊
    var noInfect: Int = 0               // 无症状感染者
    var importedCase: Int = 0           // 境外输入
    var dead: Int = 0                   // 累计死亡
}

