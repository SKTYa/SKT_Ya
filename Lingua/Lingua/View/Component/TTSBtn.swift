//
//  TTSBtn.swift
//  Lingua
//
//  Created by 김다빈 on 2023/09/02.
//

import SwiftUI

struct TTSBtn: View {
    var ttsText: String
    var body: some View {
        Button {
            TTSManager.shared.play(ttsText)
        } label: {
            Circle()
                .overlay(){
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(Color("wht"))
                    
                }
                .foregroundColor(Color("list_fill"))
                .frame(width:40, height:40)
        }


    }
}

struct TTSBtn_Previews: PreviewProvider {
    static var previews: some View {
        TTSBtn(ttsText: "테스트입니다")
    }
}
