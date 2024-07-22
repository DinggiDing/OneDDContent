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
            ZStack(alignment: .center, content: {
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
                    .frame(minHeight: 40)
                    .padding()

            })
            .padding(.vertical, 15)
        }
        
    }
}

#Preview {
    @State var text = ""
    return CustomTextField(text: $text,
                           hint: "Hint")
}
