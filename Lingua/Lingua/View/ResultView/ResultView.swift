//
//  ResultView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/09/01.
//

import SwiftUI

struct RotatedTopHalfCircle: Shape {
    var percentage: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 180 * Double(percentage))
        
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}





struct ResultView: View {
    
    var percentage: Double // 퍼센티지 값 (0.0 ~ 1.0)
    
    @State private var breathNum: Int = 1 // Example breath number
    @State private var speedNum: Int = 5 // Example speed number

    
    
    var body: some View {
        
            ZStack(){
                Color("BG").edgesIgnoringSafeArea(.all)
                
                
                ScrollView(){
                    
                    VStack(spacing : 20){
                        
                        
                        HStack(){
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 17).weight(.bold))
                                .frame(width:48, height:64)
                            //                        .border(Color.red, width:2)
                            
                            
                            
                            Spacer().frame(width:70)
                            
                            
                            
                            Text("2023년 8월 31일")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 20).weight(.bold))
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal, -16)
                        //                .border(Color.green, width:2)
                        
                        HStack(){
                            Text("총 ")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 22).weight(.bold)) +
                            Text("4문장")
                                .foregroundColor(Color("Secondary"))
                                .font(.system(size: 34).weight(.bold)) +
                            Text("을 학습했어요")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 22).weight(.bold))
                            
                            Spacer()
                            
                        }
                        
                        Spacer().frame(height:5.6)
                        
                        ZStack(){
                            
                            RoundedRectangle(cornerRadius: 24)
                                .frame(width:360, height:297)
                                .foregroundStyle(LinearGradient(
                                    colors: [Color("Primary"), Color("Secondary")],
                                    startPoint: .top, endPoint: .bottom))
                            
                            
                            
                            RoundedRectangle(cornerRadius : 24)
                                .frame(width:358, height:295)
                                .foregroundColor(Color("list_fill"))
                                .overlay(){
                                    VStack(){
                                        
                                        HStack(){
                                            Text("발음 정확도")
                                                .foregroundColor(Color("wht"))
                                                .font(.system(size: 14).weight(.bold))
                                            Spacer()
                                        }
                                        .padding(.leading, 27)
                                        
                                        ZStack {
                                            
                                            Image("circular")
                                                .resizable()
                                                .frame(width:283, height:150)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        Spacer().frame(height:24)
                                        
                                        
                                        Text("님 발음 좀 치는 듯?")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 16).weight(.bold))
                                        
                                        
                                    }
                                }
                            
                            
                            
                            
                        }
                        
                        
                        ZStack(){
                            
                            RoundedRectangle(cornerRadius: 24)
                                .frame(width:360, height:297)
                                .foregroundStyle(LinearGradient(
                                    colors: [Color("Primary"), Color("Secondary")],
                                    startPoint: .top, endPoint: .bottom))
                            RoundedRectangle(cornerRadius : 24)
                                .frame(width:358, height:295)
                                .foregroundColor(Color("list_fill"))
                                .overlay(){
                                    VStack(){
                                        
                                        HStack(){
                                            Text("호흡 횟수")
                                                .foregroundColor(Color("wht"))
                                                .font(.system(size: 14).weight(.bold))
                                            Spacer()
                                        }
                                        .padding(.leading, 27)
                                        
                                        Spacer().frame(height:23.5)
                                        
                                        ZStack(alignment: .leading) {
                                            
                                            Image("progressbar")
                                                .resizable()
                                                .frame(width:304, height:32)
                                            
                                            Image("breathbar")
                                                .resizable()
                                                .frame(width: CGFloat(breathNum) / 6 * 304, height: 32)
                                        }
                                        
                                        
                                        Spacer().frame(height:24)
                                        
                                        
                                        Text("호흡 \(breathNum)회")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 16).weight(.bold))
                                        
                                        Spacer().frame(height:12)
                                        
                                        Text("권장호흡 4회")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 14).weight(.bold))
                                            .opacity(0.3)
                                        
                                        
                                    }
                                }
                        }
                        
                        
                        ZStack(){
                            
                            RoundedRectangle(cornerRadius: 24)
                                .frame(width:360, height:297)
                                .foregroundStyle(LinearGradient(
                                    colors: [Color("Primary"), Color("Secondary")],
                                    startPoint: .top, endPoint: .bottom))
                            
                            RoundedRectangle(cornerRadius : 24)
                                .frame(width:358, height:295)
                                .foregroundColor(Color("list_fill"))
                                .overlay(){
                                    VStack(){
                                        
                                        HStack(){
                                            Text("속도")
                                                .foregroundColor(Color("wht"))
                                                .font(.system(size: 14).weight(.bold))
                                            Spacer()
                                        }
                                        .padding(.leading, 27)
                                        
                                        ZStack(alignment: .leading) {
                                            
                                            Image("progressbar")
                                                .resizable()
                                                .frame(width:304, height:32)
                                            
                                            Image("speedbar")
                                                .resizable()
                                                .frame(width: CGFloat(speedNum) / 6 * 304, height: 32)
                                            
                                        }
                                        
                                        
                                        Spacer().frame(height:24)
                                        
                                        
                                        Text("속도 7초")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 16).weight(.bold))
                                        
                                        Spacer().frame(height:12)
                                        
                                        Text("권장호흡 9초")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 14).weight(.bold))
                                            .opacity(0.3)
                                        
                                        
                                    }
                                }
                        }
                        
                        ZStack(){
                            
                            RoundedRectangle(cornerRadius: 24)
                                .frame(width:360, height:297)
                                .foregroundStyle(LinearGradient(
                                    colors: [Color("Primary"), Color("Secondary")],
                                    startPoint: .top, endPoint: .bottom))
                            RoundedRectangle(cornerRadius : 24)
                                .frame(width:358, height:433)
                                .foregroundColor(Color("list_fill"))
                                .overlay(){
                                    VStack(){
                                        
                                        
                                        HStack(){
                                            Text("발음 정확도")
                                                .foregroundColor(Color("wht"))
                                                .font(.system(size: 14).weight(.bold))
                                            Spacer()
                                        }
                                        .padding(.leading, 27)
                                        
                                        
                                        ZStack {
                                            
                                            Image("chart")
                                                .resizable()
                                                .frame(width:292, height:277)
                                            
                                        }
                                        
                                        
                                        Spacer().frame(height:24)
                                        
                                        
                                        Text("님 발음 좀 치는 듯?")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 16).weight(.bold))
                                        
                                        
                                    }
                                }
                        }
                        
                        Spacer()
                        
                        
                    }
                    .padding(16)
                    .frame(maxWidth:.infinity)
                    
                }
                
                
                
                
            
        }
        
        
        
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(percentage: 0.8)
    }
}
