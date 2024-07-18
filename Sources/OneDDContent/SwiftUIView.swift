//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

public struct SwiftUIView: View {
    
    
    // public initializer 추가
    public init() {

    }
    
    public var body: some View {
        NavigationStack {
            NavigationLink(destination: {
                SwiftUIView_2()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 5)

                    VStack {
                        Spacer().frame(height: 10)
                        HStack {
                            ZStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("오늘 하루 되돌아 보기")
                                            .font(.system(.title3, weight: .black))
                                            .foregroundStyle(.black)
                                            .multilineTextAlignment(.leading)
                                        Text("오늘 하루 되돌아 보기")
                                            .font(.system(.caption))
                                            .foregroundStyle(.black)
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            })
        }
    }
}

#Preview {
    SwiftUIView()
}

public extension Color {
    static let blackblue55 = Color(UIColor(named: "blackblue55", in: .module, compatibleWith: nil)!)
}
