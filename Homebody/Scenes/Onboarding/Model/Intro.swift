//
//  Intro.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/15.
//

import SwiftUI

// MARK: - Intro Model And Sample Intro's

struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var text: String
}

var intros: [Intro] = [
    .init(imageName: "manTea", title: "집돌, 집순 모여라", text: "'집에서 나가는 날이 언제가 좋을까..?'\n이런 고민 해본 적 없으신가요?\n그렇다면 'Homebody'가 최고의 선택이 될 거에요."),
    .init(imageName: "manSofa", title: "신중해지는 우리", text: "고민하지 마요 'Homebody'해요\n캘린더를 클릭하고 나가도 되는 안전한 날인지 확인해요\n그럼 만나보실까요?")
]
