//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI
import ConcentricOnboarding

public struct SwiftUIView: View {
    @State private var currentIndex: Int = 0

    
    // public initializer 추가
    public init() {

    }
    
    public var body: some View {
        ConcentricOnboardingView(pageContents: MockData.pages.map { (PageView(page: $0), $0.color) })
            .duration(1.0)
            .nextIcon("chevron.forward")
            .animationDidEnd {
                print("Animation Did End")
            }
    }
    
   
}

#Preview {
    SwiftUIView()
}

public extension Color {
    static let blackblue55 = Color(UIColor(named: "blackblue55", in: .module, compatibleWith: nil)!)
}
