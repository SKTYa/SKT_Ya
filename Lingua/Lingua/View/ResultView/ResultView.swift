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

//enum ImageState {
//    case first, second, third, fourth
//}

struct CircularImage: View {
    var percentage: Double
    
    enum ImageState {
        case first, second, third, fourth
    }
    
    private var imageState: ImageState {
        switch (percentage / 100) * 180 {
        case 0..<93:
            return .first
        case 93..<126:
            return .second
        case 126..<153:
            return .third
        case 153...180:
            return .fourth
        default:
            return .first // Handle any other cases if needed
        }
    }
    
    
    var body: some View {
        var imageName: String
        switch imageState {
        case .first:
            imageName = "orbit_First"
        case .second:
            imageName = "orbit_Second"
        case .third:
            imageName = "orbit_Third"
        case .fourth:
            imageName = "orbit_Fourth"
        }
        
        return Image(imageName)
            .resizable()
            .frame(width: 283, height: 150)
    }
}




struct CircularShape: Shape {
    var percentage: Double
    
    var animatableData: Double {
        get { return percentage }
        set { percentage = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY-30)
        let radius: CGFloat = 127
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 180 * (percentage / 100))
        
        
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        
        return path
    }
}





struct ResultView: View {
    
    @EnvironmentObject var wordNetwork: NetworkManagerWord
    @EnvironmentObject var sentenceNetwork: NetworkManagerSentence
    
    @State var option: Int
    
    //    var percentage: Double // 퍼센티지 값 (0.0 ~ 1.0)
    @State var percentage: Double = 0 // Initial percentage
    
    
    
    @State private var breathNum: Int = 3 // Example breath number
    @State private var speedNum: Int = 5 // Example speed number
    @State private var endPoint: CGPoint = .zero
    
    
    
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
                                    
                                    Spacer().frame(height:32)
                                    
                                    HStack(){
                                        Text("발음 정확도")
                                            .foregroundColor(Color("wht"))
                                            .font(.system(size: 14).weight(.bold))
                                        Spacer()
                                    }
                                    .padding(.leading, 27)
                                    
                                    
                                    
                                    ZStack {
                                        
                                        if option == 1 {
                                            var score = Double(sentenceNetwork.checkSentences.similarity ?? 0)
                                            
                                            CircularImage(percentage: score)
                                                .frame(width: 283, height: 150)
                                            
                                            
                                            Text(" \(Int(score))%")
                                                .foregroundColor(Color("Primary"))
                                                .font(.system(size: 48).weight(.bold))
                                                .padding(.top, 115)
                                            
                                            
                                            ZStack {
                                                GeometryReader { geometry in
                                                    CircularShape(percentage: score)
                                                        .fill(Color("list_fill"))
                                                        .opacity(0)
                                                        .rotationEffect(.degrees(180))
                                                        .animation(.easeInOut(duration: 1))
                                                        .onReceive([score].publisher.first()) { _ in
                                                            // Calculate the endpoint of the circular segment whenever percentage changes
                                                            let center = CGPoint(x: geometry.size.width / 2 , y: geometry.size.height / 2 - 65 )
                                                            let radius: CGFloat = 133.5
                                                            
                                                            let endAngle = Angle(degrees: 180 * (score / 100))
                                                            endPoint = CGPoint(x: center.x + radius * cos(CGFloat(endAngle.radians)), y: center.y + radius * sin(CGFloat(endAngle.radians)))
                                                            
                                                        }
                                                }
                                                
                                                ZStack(){
                                                    
                                                    Ellipse()
                                                        .fill(Color("Primary"))
                                                        .frame(width: 28, height: 28)
                                                        .position(endPoint)
                                                        .rotationEffect(.degrees(180)) // Rotate around x-axis
                                                    
                                                    Ellipse()
                                                        .fill(Color.black)
                                                        .frame(width: 12, height: 12)
                                                        .position(endPoint)
                                                        .rotationEffect(.degrees(180))
                                                }
                                            }
                                        }
                                        else {
                                            CircularImage(percentage: percentage)
                                                .frame(width: 283, height: 150)
                                            
                                            
                                            Text(" \(Int(percentage))%")
                                                .foregroundColor(Color("Primary"))
                                                .font(.system(size: 48).weight(.bold))
                                                .padding(.top, 115)
                                            
                                            
                                            ZStack {
                                                GeometryReader { geometry in
                                                    CircularShape(percentage: percentage)
                                                        .fill(Color("list_fill"))
                                                        .opacity(0)
                                                        .rotationEffect(.degrees(180))
                                                        .animation(.easeInOut(duration: 1))
                                                        .onReceive([self.percentage].publisher.first()) { _ in
                                                            // Calculate the endpoint of the circular segment whenever percentage changes
                                                            let center = CGPoint(x: geometry.size.width / 2 , y: geometry.size.height / 2 - 65 )
                                                            let radius: CGFloat = 133.5
                                                            
                                                            let endAngle = Angle(degrees: 180 * (percentage / 100))
                                                            endPoint = CGPoint(x: center.x + radius * cos(CGFloat(endAngle.radians)), y: center.y + radius * sin(CGFloat(endAngle.radians)))
                                                            
                                                        }
                                                }
                                                
                                                ZStack(){
                                                    
                                                    Ellipse()
                                                        .fill(Color("Primary"))
                                                        .frame(width: 28, height: 28)
                                                        .position(endPoint)
                                                        .rotationEffect(.degrees(180)) // Rotate around x-axis
                                                    
                                                    Ellipse()
                                                        .fill(Color.black)
                                                        .frame(width: 12, height: 12)
                                                        .position(endPoint)
                                                        .rotationEffect(.degrees(180))
                                                }
                                            }
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    Spacer().frame(height:24)
                                    
                                    
                                    Text("님 발음 좀 치는 듯?")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 16).weight(.bold))
                                    
                                    Spacer().frame(height:26)
                                    
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
                            .frame(width:360, height:435)
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
        ResultView(option: 0, percentage: 79)
    }
}
