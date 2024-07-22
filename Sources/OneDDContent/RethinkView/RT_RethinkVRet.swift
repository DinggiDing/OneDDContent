//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

public struct RT_RethinkVRet: View {
    @State private var pageNumber: Int = 0
    @State private var isSheeted: Bool = false
    
    // public initializer 추가
    public init() {

    }
    
    public var body: some View {

            VStack {
                Spacer().frame(height: 10)
                HStack {
                    ZStack(alignment: .bottom) {
                        Image("reflect", bundle: .module)
                            .resizable()
                            .frame(height: 231)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        
                        
                        VStack {
                            LinearGradient(colors: [Color.clear, Color.clear, Color.black], startPoint: .top, endPoint: .bottom)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 0,
                                        bottomLeadingRadius: 20,
                                        bottomTrailingRadius: 20,
                                        topTrailingRadius: 0
                                    )
                                )
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("오늘 하루 되돌아 보기")
                                    .font(.system(.headline, weight: .black))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                                Text("5개의 질문")
                                    .font(.system(.caption))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                        }
                        .padding()

                    }
                    .frame(height: 231)
                }
                .onTapGesture {
                    isSheeted.toggle()
                }
                .padding()
            }
            
            .sheet(isPresented: $isSheeted, content: {
                RF_PageView()
            })

    }
    
}

#Preview {
    RT_RethinkVRet()
        .background(Color.gray)
}

public extension Color {
    static let blackblue55 = Color(UIColor(named: "blackblue55", in: .module, compatibleWith: nil)!)
    static let whiteblue = Color(UIColor(named: "whiteblue", in: .module, compatibleWith: nil)!)
    static let maingra = Color(UIColor(named: "maingra", in: .module, compatibleWith: nil)!)
    static let mainpoint = Color(UIColor(named: "mainpoint", in: .module, compatibleWith: nil)!)
}
