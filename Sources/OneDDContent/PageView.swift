//
//  SwiftUIView 2.swift
//  
//
//  Created by 성재 on 7/18/24.
//

import SwiftUI

struct PageView: View {
    
    //MARK: - Properties
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size, keyboardHeight: $keyboardHeight)
            
        } //: GEOMETRY
        .padding(15)
        /// Disabling native keyboard push
        .ignoresSafeArea(.keyboard, edges: .all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { output in
            if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                keyboardHeight = height
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { output in
            keyboardHeight = 0
        })
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
    }
}

struct IntroView: View {
    @State private var email: String = ""
    @Binding var intro: PageIntro
    @Binding var keyboardHeight: CGFloat
    var size: CGSize
    
    init(intro: Binding<PageIntro>, size: CGSize, keyboardHeight: Binding<CGFloat>) {
        self._intro = intro
        self.size = size
        self._keyboardHeight = keyboardHeight
    }
    
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader {
                
                let size = $0.size
                
                VStack(alignment: .leading, spacing: 4) {
                    
//                    Spacer(minLength: 0)
                    Text(intro.title)
                        .font(.system(size: 30))
                        .fontWeight(.black)
                    
                    Text(intro.subtitle)
                        .font(.system(size: 16))
                        .foregroundStyle(.black.opacity(0.8))
                        .padding(.top, 12)
                    
                    /// Custom Indicator View
                    CustomIndicatorView(totalPages: filteredPages.count,
                                        currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                        .padding(.top, 48)

                    CustomTextField(text: $email, hint: "Email Address", leadingIcon: Image(systemName: "envelope"))
                        .padding(.top, 28)

                }
                .padding(.top, 64)
                
            } //: GEOMETRY
            /// Moving From Up to Down
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            
            /// Tile Actions
            VStack(alignment: .leading, spacing: 10) {
                                
                Group {

                    Spacer(minLength: 80)
                    
                    Button(action: {
                        changeIntro()
                    }, label: {
                        Text("Next")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: size.width * 0.8)
                            .padding(.vertical, 15)
                            .background(.black, in: .capsule)
                    })
                    
                    
                } //: GROUP
                .frame(maxWidth: .infinity, alignment: .center)
                
            } //: VSTACK
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Moving From Down to Up
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
            /// Manually pushing Keyboard
            .offset(y: -keyboardHeight)

                                    
        } //: VSTACK
        /// Moving From Down to Up
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        /// Back Button
        .overlay(alignment: .topLeading) {
            if intro != pageIntros.first {
                Button(action: {
                    changeIntro(true)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .contentShape(.rect)
                })
                .padding(10)
                /// Back button comes from top
                .offset(y: showView ? 0 : -200)
                /// Goes up again when inactive
                .offset(y: hideWholeView ? -200 : 0)
            }
        } //: Overlay Back Button
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                self.showView = true
            }
        }
        
    }
    
    
    // MARK: - Functions
    
    private func changeIntro(_ isPrevious: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            self.hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let index = pageIntros.firstIndex(of: intro),
                (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                
                intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            
            /// Re-updating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                self.showView = true
            }
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter( { !$0.displaysAction })
    }
    
}

#Preview {
    PageView()
}
