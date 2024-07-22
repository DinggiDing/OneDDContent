//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/20/24.
//

import SwiftUI
import BigUIPaging

public struct InD_SwiftUIView: View {
    
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
            
            .pageViewStyle(.cardDeck)
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
    InD_SwiftUIView()
}

struct DeckStyleSubView: View {
    let value: Int
    let title: LocalizedStringKey
    let bodytext: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.whiteblue)
                    .ignoresSafeArea()
                HStack {
                    Rectangle().frame(width: 2, alignment: .center)
                        .foregroundStyle(Color.maingra)
                        .shadow(color: .maingra.opacity(0.8), radius: 5, x: 0, y: 5)
                        .padding(.vertical, 20)
                    VStack(alignment: .leading, spacing: 12) {
                        //                    Text("[ \(title) ]", bundle: .module)
                        Text(title, bundle: .module)
                            .font(.headline)
                        Text(bodytext)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(7.0)

                    }
                    .padding(.leading, 12)
                    Spacer()
                }
                .padding(.horizontal, 28)
                
            }              
            
        }
    }
}
