//
//  SwiftUIView 2.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

struct RF_PageView: View {
    @Environment(\.locale) var locale // Access the current locale

    //MARK: - Properties
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var gotoroot: Bool = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size, keyboardHeight: $keyboardHeight)
    
        } //: GEOMETRY
        .padding(15)
        /// Disabling native keyboard push
        .ignoresSafeArea(.keyboard, edges: .all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { output in
            if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                keyboardHeight = height
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { output in
            keyboardHeight = 0
        })
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
    }
    
    // Function to get intros based on locale
    
}

struct IntroView: View {
    @State private var email: String = ""
    @AppStorage("reflection1") var reflection1: String = ""
    @AppStorage("reflection2") var reflection2: String = ""
    @AppStorage("reflection3") var reflection3: String = ""
    @AppStorage("reflection4") var reflection4: String = ""
    @AppStorage("reflection5") var reflection5: String = ""
    
    @Binding var intro: PageIntro

    @Binding var keyboardHeight: CGFloat
    var size: CGSize
    @Environment(\.dismiss) var dismiss
    
    init(intro: Binding<PageIntro>, size: CGSize, keyboardHeight: Binding<CGFloat>) {
        self._intro = intro
        self.size = size
        self._keyboardHeight = keyboardHeight
    }
    
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader {
                
                let size = $0.size
                
                VStack(alignment: .leading, spacing: 4) {
                    
//                    Spacer(minLength: 0)
//                    HighlightedText("오늘 아침에 일어나서 세운 ###목표$$$는 무엇이었나요?")
//                        .font(.system(size: 24))
//                        .fontWeight(.black)
                    HighlightedText(intro.title)
                        .font(.system(size: 24))
                        .fontWeight(.black)

                    Text(NSLocalizedString("\(intro.subtitle)", bundle: .module, comment: ""))
                        .font(.system(size: 14))
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(.top, 12)
                    
                    HStack(alignment: .bottom) {
                        Text("Question \((filteredPages.firstIndex(of: intro) ?? 0) + 1)")
                            .fontWeight(.semibold)
                        Text("of 5")
                            .fontWeight(.regular)
                            .foregroundStyle(.black.opacity(0.4))
                        Spacer()
                    }
                    .padding(.top, 48)
                
                    /// Custom Indicator View
                    CustomIndicatorView(totalPages: filteredPages.count,
                                        currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                        .frame(width: size.width)
                        .padding(.top, 4)
                    
                    if let index = filteredPages.firstIndex(of: intro) {
                        switch index {
                        case 0:
                            CustomTextField(text: $reflection1, hint: "Answer")
                                .padding(.top, 28)
                        case 1:
                            CustomTextField(text: $reflection2, hint: "Answer")
                                .padding(.top, 28)
                        case 2:
                            CustomTextField(text: $reflection3, hint: "Answer")
                                .padding(.top, 28)
                        case 3:
                            CustomTextField(text: $reflection4, hint: "Answer")
                                .padding(.top, 28)
                        case 4:
                            CustomTextField(text: $reflection5, hint: "Answer")
                                .padding(.top, 28)
                        default:
                            CustomTextField(text: $reflection1, hint: "Answer")
                                .padding(.top, 28)
                        }
//                        CustomTextField(text: $email, hint: "Answer")
//                            .padding(.top, 28)
                    }
                }
                .padding(.top, 32)
            } //: GEOMETRY
            /// Moving From Up to Down
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            .offset(y: -keyboardHeight/8)
            
            
            /// Tile Actions
            VStack(alignment: .leading, spacing: 10) {
                                
                Group {

                    Spacer(minLength: 80)
                    
                    HStack {
                        
                        if intro != pageIntros.first {
                            Button(action: {
                                changeIntro(true)
                            }, label: {
                                Text("Prev")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.blackblue55)
                                    .frame(width: size.width * 0.4)
                                    .padding(.vertical, 15)
                                    .background(.white, in: .capsule)
                            })
                        }
                        
                        Button(action: {
                            if intro == pageIntros.last {
                                dismiss()
                            } else {
                                changeIntro()
                            }
                        }, label: {
                            if intro == pageIntros.last {
                                Text("Done")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: size.width * 0.4)
                                    .padding(.vertical, 15)
                                    .background(.black, in: .capsule)
                            } else {
                                Text("Next")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: size.width * 0.4)
                                    .padding(.vertical, 15)
                                    .background(Color.blackblue55, in: .capsule)
                            }
                        })
                    }
                    
                    
                } //: GROUP
                .frame(maxWidth: .infinity, alignment: .center)
                
            } //: VSTACK
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Moving From Down to Up
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
            /// ManupageIntrosy pushing Keyboard
            .offset(y: -keyboardHeight)

                                    
        } //: VSTACK
        /// Moving From Down to Up
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                self.showView = true
            }
        }
        
    }
    
    
    // MARK: - Functions
    
    private func changeIntro(_ isPrevious: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            self.hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let index = pageIntros.firstIndex(of: intro),
                (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                
                intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            
            /// Re-updating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                self.showView = true
            }
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter( { !$0.displaysAction })
    }
    
}

#Preview {
    RF_PageView()
        .environment(\.locale, .init(identifier: "ko"))

}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct HighlightedText: View{
    let text: Text
    
    private static let regularExpression = try! NSRegularExpression(
        pattern: "###(?<content>((?!\\$\\$\\$).)*)\\$\\$\\$"
    )
    
    private struct SubstringRange {
        let content: NSRange
        let full: NSRange
    }
    
    init(_ string: String) {
        let localizedString = NSLocalizedString(string, bundle: .module, comment: "")

        let ranges = Self.regularExpression
            .matches(
                in: localizedString,
                options: [],
                range: NSRange(location: 0, length: localizedString.count)
            )
            .map { match in
                SubstringRange(
                    content: match.range(withName: "content"),
                    full: match.range(at: 0)
                )
            }
        var nextNotProcessedSymbol = 0
        var text = Text("")
        let nsString = localizedString as NSString
        func appendSubstringStartingNextIfNeeded(until endLocation: Int) {
            if nextNotProcessedSymbol < endLocation {
                text = text + Text(nsString.substring(
                    with: NSRange(
                        location: nextNotProcessedSymbol,
                        length: endLocation - nextNotProcessedSymbol
                    )
                ))
            }
        }
        for range in ranges {
            appendSubstringStartingNextIfNeeded(until: range.full.location)
            text = text + Text(nsString.substring(with: range.content))
                .foregroundColor(Color.red)
            nextNotProcessedSymbol = range.full.upperBound
        }
        appendSubstringStartingNextIfNeeded(until: localizedString.count)
        self.text = text
    }
    
    var body: some View {
        text
    }
}
