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
//        NavigationStack {
//            NavigationLink(destination: {
//                RF_PageView()
//            }, label: {
                    VStack {
                        Spacer().frame(height: 10)
                        HStack {
                            ZStack(alignment: .bottom) {
                                Image("reflect", bundle: .module)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                
                                ZStack {
                                    Rectangle()
                                        .fill(.white)
                                    HStack {
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text("오늘 하루 되돌아 보기")
                                                .font(.system(.title3, weight: .black))
                                                .foregroundStyle(.black)
                                                .multilineTextAlignment(.leading)
                                            Text("5개의 질문")
                                                .font(.system(.caption))
                                                .foregroundStyle(.black)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.black)
                                    }
                                    .padding()
                                }
                                .frame(height: 68)
                            }
                            .frame(width: 341, height: 231)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .onTapGesture {
                        isSheeted.toggle()
                    }
                    .sheet(isPresented: $isSheeted, content: {
                        RF_PageView()
                    })
//            })
//        }
    }
    
}

#Preview {
    RT_RethinkVRet()
}

public extension Color {
    static let blackblue55 = Color(UIColor(named: "blackblue55", in: .module, compatibleWith: nil)!)
    static let whiteblue = Color(UIColor(named: "whiteblue", in: .module, compatibleWith: nil)!)
    static let maingra = Color(UIColor(named: "maingra", in: .module, compatibleWith: nil)!)
    static let mainpoint = Color(UIColor(named: "mainpoint", in: .module, compatibleWith: nil)!)
}
