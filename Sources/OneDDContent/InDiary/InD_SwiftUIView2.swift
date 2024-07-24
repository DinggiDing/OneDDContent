//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/24/24.
//

import SwiftUI
import BigUIPaging

public struct InD_SwiftUIView2: View {
    @State private var selection: Int = 0
    @AppStorage("reflection1") var reflection1: String = ""
    @AppStorage("reflection2") var reflection2: String = ""
    @AppStorage("reflection3") var reflection3: String = ""
    @AppStorage("reflection4") var reflection4: String = ""
    @AppStorage("reflection5") var reflection5: String = ""
    @State private var istouched: Bool = false

    
    // public initializer 추가
    public init() {

    }
    
    public var body: some View {
        VStack(spacing: 0) {
            PageView(selection: $selection) {
                ForEach(0..<5, id: \.self) { id in
                    
                    DeckStyleSubView(value: id, title: DiaryData.title[id], bodytext: reflectionValue(for: id))
                    
                }
            }
            .onTapGesture {
                istouched.toggle()
            }
            .frame(minHeight: istouched ? 210 : 110)
            .fixedSize(horizontal: false, vertical: true) // Allow text to expand vertically
            
            .pageViewStyle(.scroll)
            .pageViewCardCornerRadius(20)
            
            PageIndicator(
                selection: $selection,
                total: 5
            )
            .pageIndicatorBackgroundStyle(.prominent)
            
        }
    }
    
    // Function to get the reflection value by id
   func reflectionValue(for id: Int) -> String {
       switch id {
       case 0:
           return reflection1
       case 1:
           return reflection2
       case 2:
           return reflection3
       case 3:
           return reflection4
       case 4:
           return reflection5
       default:
           return reflection1 // default case, should not happen
       }
   }
}

#Preview {
    InD_SwiftUIView2()
}
