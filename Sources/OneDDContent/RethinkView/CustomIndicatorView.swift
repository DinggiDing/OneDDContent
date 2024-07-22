//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

struct CustomIndicatorView: View {
    
    //MARK: - Propeties
    var totalPages: Int
    var currentPage: Int
    var activeTint: Color = Color.maingra
    var inactiveTint: Color = .gray.opacity(0.2)
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<totalPages, id: \.self) { index in
                RoundedRectangle(cornerRadius: 0.0)
                    .fill(currentPage >= index ? activeTint : inactiveTint)
                    .frame(height: 4)
            } //: Loop Pages
        } //: HSTACK
    }
}

#Preview {
    CustomIndicatorView(totalPages: 3, currentPage: 1)
}
