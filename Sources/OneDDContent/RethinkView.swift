//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

public struct RethinkView: View {
    @State private var pageNumber: Int = 0

    
    // public initializer 추가
    public init() {

    }
    
    public var body: some View {
        PageView() 
    }
    
}

#Preview {
    RethinkView()
}

public extension Color {
    static let blackblue55 = Color(UIColor(named: "blackblue55", in: .module, compatibleWith: nil)!)
}
