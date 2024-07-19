//
//  SwiftUIView.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

struct CustomTextField: View {
    
    //MARK: - Properties
    @Binding var text: String
    var hint: String
//    var leadingIcon: Image
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .top, content: {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.whiteblue)
                    .onTapGesture {
                        isKeyboardShowing = true
                    }
                
                TextField(hint, text: $text, axis: .vertical)
                    .focused($isKeyboardShowing)
                    .onChange(of: text) { text in
                        self.text = String(text.prefix(20))
                    }
                    .padding()
            })
//            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
//        HStack(spacing: -10) {
//            
//        } //: HSTACK
        
    }
}

#Preview {
    @State var text = ""
    return CustomTextField(text: $text,
                           hint: "Hint")
}
