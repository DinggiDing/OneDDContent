// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

struct PageIntro: Identifiable, Hashable {
    let id = UUID()
    var introAssetImage: String
    var title: String
    var subtitle: String
    var displaysAction: Bool = false
}


var pageIntros: [PageIntro] = [
    .init(introAssetImage: "Page 1", title: "오늘 아침에 일어나서 세운 목표는 무엇이었나요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 2", title: "그 도전을 어떻게 달성했나요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 3", title: "오늘 누구와 가장 많은 상호작용을 했나요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 4", title: "오늘 배운 새로운 것은 무엇인가요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 5", title: "오늘 감사했던 일은 무엇인가요?", subtitle: "키워드 위주로 작성해주세요"),
//    .init(introAssetImage: "Page 3", title: "Let's\nGet Started", subtitle: "To register for an account, kindly enter your details.", displaysAction: true),
]
