//
//  ContentView.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 06.12.2021.
//

import SwiftUI





struct ContentView: View {

    @State private var angle: CGFloat = 0
    var repeatCount = 5
    var repeatAnimation: Animation{
        Animation
            
            .spring(response: 1.3, dampingFraction: 2.3, blendDuration: 0)
        //.repeatForever(autoreverses: false)
            
    }
    var endAnimation: Animation{
        Animation
            .easeOut(duration: 2)
            .delay(Double(repeatCount) * 0.5)
            
    }
    
    
    @StateObject var wheelViewModel: WheelViewModel = WheelViewModel()
    
    var body: some View {
        VStack{
            Wheel(wheelViewModel: wheelViewModel)
                .rotationEffect(.degrees(angle))
                .onTapGesture {
                    angle = 0//angle.truncatingRemainder(dividingBy: 360)
                    print(angle)
                    withAnimation(self.repeatAnimation) {
                        angle = CGFloat.random(in: angle...360 * 6)
                        //angle = CGFloat.random(in: angle+3600...angle+7200)
                    }
                }
            
            
                
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
