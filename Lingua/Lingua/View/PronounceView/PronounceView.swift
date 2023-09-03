import SwiftUI

struct PronounceView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedOptionIndex: Int

    private let options = ["1단계 단어 말하기", "2단계 문장 말하기", "3단계 문단 말하기"]
    @ObservedObject var audioRecorderManger: AudioRecorderManger
    
    @State private var selectedTab = 0
    @Binding var isResult: Bool
    @Binding var isComplete: Bool


    
    
    var body: some View {
        ZStack(alignment: .top){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            VStack() {
                ZStack{
                    HStack(spacing : 38){
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 22).weight(.bold))
                                .frame(width:48, height:64)
                                .bold()
                        }
                        //                .padding(.leading, -16)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .center){
                        Spacer()
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width:192, height:48)
                            .overlay(){
                                Text("\(options[selectedOptionIndex])")
                                    .foregroundColor(Color("Primary"))
                                    .font(.system(size: 20).weight(.bold))
                            }
                            .foregroundColor(Color("list_fill"))
                        Spacer()
                    }
                    .frame(width: .infinity)
                }
                
                Spacer()
                
                 
                PronounceTab(selectedOptionIndex: selectedOptionIndex, audioRecorderManger: audioRecorderManger)
                

                
                HStack(){
                    
                    Button{
                        self.$isResult.wrappedValue = false
                    }label: {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 174, height:64)
                            .overlay(){
                                HStack(){
                                    Text("다음 문장")
                                        .foregroundColor(Color("bk"))
                                        .font(.system(size: 22).weight(.bold))
                                }
                            }
                            .foregroundColor(Color("Primary"))
                    }
                    
                    Button{
                        self.$isResult.wrappedValue = false
                        self.$isComplete.wrappedValue = true
                    }label: {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 88, height:64)
                            .overlay(){
                                HStack(){
                                    Text("완료")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 22).weight(.bold))
                                }
                            }
                            .foregroundColor(Color("list_fill"))
                    }
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: 64, height:64)
                        .overlay(){
                            HStack(){
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(Color("bk"))
                                    .font(.system(size: 24).weight(.bold))
                            }
                        }
                        .foregroundColor(Color("Primary"))
                    
                }
                .padding(16)
                
                
            }
            
        }


    }
}

//struct PronounceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PronounceView(selectedOptionIndex: 0, isResult: )
//    }
//}
