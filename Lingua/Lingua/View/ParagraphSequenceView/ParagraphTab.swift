


import SwiftUI

struct ParagraphTab: View {
    
    @Binding var currentSentenceIndex: Int

    
    let tabs = ["발음", "호흡"] // 새로운 탭 항목들
    
    @State var selected = "발음" // 기본 선택된 탭 변경
    @State var animationSelected = "발음"
    @Namespace var namespace
    
    let sentences: [ParagraphSequneceView.Sentence] // Add this line
    
    //    init(sentences: [ParagraphSequneceView.Sentence]) { // Add this initializer
    //            self.sentences = sentences
    //        }
    
    
    init(currentSentenceIndex: Binding<Int>, sentences: [ParagraphSequneceView.Sentence]) {
        self._currentSentenceIndex = currentSentenceIndex
        self.sentences = sentences
    }
    
    
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
                        
                        ParagraphProFirst(currentSentenceIndex: $currentSentenceIndex, sentences: sentences)
                        
                        
                    }
                    .tag("발음")
                    
                    VStack {
                        // "호흡"에 해당하는 뷰들을 이곳에 추가
                        
                        ParagraphBreFirst(currentSentenceIndex: $currentSentenceIndex, sentences: sentences)
                        
                    }
                    .tag("호흡")
                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
                .tabViewStyle(DefaultTabViewStyle())

                
            }
        }
    }
}



//
//struct ParagraphTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ParagraphTab()
//    }
//}
