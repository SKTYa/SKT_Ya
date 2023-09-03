////
////  PronounceTab.swift
////  Lingua
////
////  Created by Jin Sang woo on 2023/08/31.
////
//
//import SwiftUI
//
//struct Tab {
//    var icon: Image?
//    var title: String
//}
//struct Tabs: View {
//
//    var fixed = true
//    var tabs: [Tab]
//    var geoWidth: CGFloat
//    @Binding var selectedTab: Int
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            ScrollViewReader { proxy in
//                VStack(spacing: 0) {
//                    HStack(spacing: 0) {
//                        ForEach(0 ..< tabs.count, id: \.self) { row in
//                            Button(action: {
//                                withAnimation {
//                                    selectedTab = row
//                                }
//                            }, label: {
//                                VStack(spacing: 0) {
//                                    HStack {
//
//                                        // Text
//                                        Text(tabs[row].title)
//                                            .font(Font.system(size: 20, weight: .semibold))
//                                            .foregroundColor(Color.white)
//                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
//                                    }
//                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
//                                    // Bar Indicator
//                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
//                                        .frame(height: 3)
//                                }.fixedSize()
//                            })
//                                .accentColor(Color.white)
//                                .buttonStyle(PlainButtonStyle())
//                        }
//                    }
//                    .onChange(of: selectedTab) { target in
//                        withAnimation {
//                            proxy.scrollTo(target)
//                        }
//                    }
//                }
//            }
//        }
//        .frame(height: 64)
//        .onAppear(perform: {
//            UIScrollView.appearance().backgroundColor = UIColor(Color("BG"))
//            UIScrollView.appearance().bounces = fixed ? false : true
//        })
//        .onDisappear(perform: {
//            UIScrollView.appearance().bounces = true
//        })
//    }
//}
//struct Tabs_Previews: PreviewProvider {
//    static var previews: some View {
//        Tabs(fixed: true,
//             tabs: [.init(icon: nil, title: "Tab 1"),
//                    .init(icon: nil, title: "Tab 2"),
//                    .init(icon: nil, title: "Tab 3")],
//             geoWidth: 375,
//             selectedTab: .constant(0))
//    }
//}

import SwiftUI




struct PronounceTab: View {
    
    
    let tabs = ["발음", "호흡"] // 새로운 탭 항목들
    
    @State var selected = "발음" // 기본 선택된 탭 변경
    @State var animationSelected = "발음"
    @State var selectedOptionIndex: Int
    @ObservedObject var audioRecorderManger: AudioRecorderManger
    
    @Namespace var namespace
    
    var body: some View {
        
        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            
            VStack() {
                HStack() {
                    
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)){
                                selected = tab
                            }
                            animationSelected = selected
                        } label: {
                            Text(tab)
                                .padding(.vertical, 12)
                                .padding(.horizontal, tab != tabs.last ? 4.5 : 0)
                                .foregroundColor(Color("wht"))
                                .frame(width: 195, height:64)
                                .font(.system(size: 20).weight(.bold))
                                .overlay(alignment: .bottom){
                                    if selected == tab{
                                        Rectangle()
                                            .frame(height: 2)
                                            .matchedGeometryEffect(id: "activeStroke", in: namespace)
                                            .foregroundColor(Color("Primary"))
                                        
                                        
                                        
                                    }
                                }
                        }
                        if tab != tabs.last {
                            Spacer()
                        }
                    }
                }
                .padding([.leading, .trailing], 15)
                .frame(maxWidth: .infinity)
                
                //                .border(Color.red, width:2)
                
                
                
                TabView(selection: $animationSelected) {
                    VStack {
                        // "발음"에 해당하는 뷰들을 이곳에 추가
                        
                        PronouncePronView(selectedOptionIndex: self.selectedOptionIndex, audioRecorderManger: audioRecorderManger)
                        
                    }
                    .tag("발음")
                    
                    VStack {
                        // "호흡"에 해당하는 뷰들을 이곳에 추가
                        PronounceBreath(selectedOptionIndex: self.selectedOptionIndex, audioRecorderManger: audioRecorderManger)
                        
                    }
                    .tag("호흡")
                }
                
                //                .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))

                .tabViewStyle(DefaultTabViewStyle())


            }
        }
    }
}



//
//struct PronounceTab_Previews: PreviewProvider {
//    static var previews: some View {
//        PronounceTab(selectedOptionIndex: 0, audioRecorderManger: )
//    }
//}
