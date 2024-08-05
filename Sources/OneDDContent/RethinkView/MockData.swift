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
    .init(introAssetImage: "Page 1", title: "오늘 아침에 일어나서 세운 ###목표$$$는 무엇이었나요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 2", title: "그 도전을 ###어떻게$$$ 달성했나요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 3", title: "오늘 ###누구$$$와 가장 많은 상호작용을 했나요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 4", title: "오늘 배운 ###새로운 것$$$은 무엇인가요?", subtitle: "키워드 위주로 작성해주세요"),
    .init(introAssetImage: "Page 5", title: "오늘 ###감사했던 일$$$은 무엇인가요?", subtitle: "키워드 위주로 작성해주세요"),
]

//    private var pageIntros_ko: [PageIntro] = [
//        .init(introAssetImage: "Page 1", title: "오늘 아침에 일어나서 세운 ###목표$$$는 무엇이었나요?", subtitle: "키워드 위주로 작성해주세요"),
//        .init(introAssetImage: "Page 2", title: "그 도전을 ###어떻게$$$ 달성했나요?", subtitle: "키워드 위주로 작성해주세요"),
//        .init(introAssetImage: "Page 3", title: "오늘 ###누구$$$와 가장 많은 상호작용을 했나요?", subtitle: "키워드 위주로 작성해주세요"),
//        .init(introAssetImage: "Page 4", title: "오늘 배운 ###새로운 것$$$은 무엇인가요?", subtitle: "키워드 위주로 작성해주세요"),
//        .init(introAssetImage: "Page 5", title: "오늘 ###감사했던 일$$$은 무엇인가요?", subtitle: "키워드 위주로 작성해주세요"),
//    ]
//    
//    private var pageIntros_en: [PageIntro] = [
//        .init(introAssetImage: "Page 1", title: "What was ###your goal$$$ when you woke up this morning?", subtitle: "Focus on Keywords"),
//        .init(introAssetImage: "Page 2", title: "###How$$$ did you achieve that challenge?", subtitle: "Focus on Keywords"),
//        .init(introAssetImage: "Page 3", title: "###Who$$$ did you interact with the most today?", subtitle: "Focus on Keywords"),
//        .init(introAssetImage: "Page 4", title: "What ###new thing$$$ did you learn today?", subtitle: "Focus on Keywords"),
//        .init(introAssetImage: "Page 5", title: "What were you ###grateful$$$ for today?", subtitle: "Focus on Keywords"),
//    ]
//    
//    private var pageIntros_ja: [PageIntro] = [
//        .init(introAssetImage: "Page 1", title: "今日の朝、起きてから立てた###目標$$$は何でしたか？", subtitle: "キーワードで作成してください"),
//        .init(introAssetImage: "Page 2", title: "そのチャレンジを###どのように$$$達成しましたか？", subtitle: "キーワードで作成してください"),
//        .init(introAssetImage: "Page 3", title: "今日###誰$$$と最も多く交流しましたか？", subtitle: "キーワードで作成してください"),
//        .init(introAssetImage: "Page 4", title: "今日学んだ###新しいこと$$$は何ですか？", subtitle: "キーワードで作成してください"),
//        .init(introAssetImage: "Page 5", title: "今日###感謝したこと$$$は何ですか？", subtitle: "キーワードで作成してください"),
//    ]
//    

