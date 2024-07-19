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
    @State private var gotoroot: Bool = false
    
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
    @AppStorage("reflection") var reflection: [String] = ["","","","",""]
    @Binding var intro: PageIntro
    @Binding var keyboardHeight: CGFloat
    var size: CGSize
    @Environment(\.dismiss) var dismiss

    
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
                        .font(.system(size: 28))
                        .fontWeight(.black)
                    
                    Text(intro.subtitle)
                        .font(.system(size: 16))
                        .foregroundStyle(.black.opacity(0.8))
                        .padding(.top, 12)
                    
                    /// Custom Indicator View
                    CustomIndicatorView(totalPages: filteredPages.count,
                                        currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                        .padding(.top, 48)

                    CustomTextField(text: $reflection[filteredPages.firstIndex(of: intro) ?? 0], hint: "Answer")
                        .padding(.top, 28)

                }
                .padding(.top, 24)
                
            } //: GEOMETRY
            /// Moving From Up to Down
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            .offset(y: -keyboardHeight/8)

            
            
            /// Tile Actions
            VStack(alignment: .leading, spacing: 10) {
                                
                Group {

                    Spacer(minLength: 80)
                    
                    HStack {
                        
                        if intro != pageIntros.first {
                            Button(action: {
                                changeIntro(true)
                            }, label: {
                                Text("Prev")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                    .frame(width: size.width * 0.4)
                                    .padding(.vertical, 15)
                                    .background(.white, in: .capsule)
                            })
                        }
                        
                        Button(action: {
                            if intro == pageIntros.last {
                                dismiss()
                            } else {
                                changeIntro()
                            }
                        }, label: {
                            if intro == pageIntros.last {
                                Text("Done")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: size.width * 0.4)
                                    .padding(.vertical, 15)
                                    .background(.black, in: .capsule)
                            } else {
                                Text("Next")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: size.width * 0.4)
                                    .padding(.vertical, 15)
                                    .background(.black, in: .capsule)
                            }
                        })
                        
                    }
                    
                    
                    
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

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
