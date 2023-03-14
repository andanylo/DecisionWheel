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
            .timingCurve(0, 0.8, 0.1, 1, duration: Double(wheelViewModel.rotationDuration))
    }
    var endAnimation: Animation{
        Animation
            .easeOut(duration: 2)
            .delay(Double(repeatCount) * 0.5)
            
    }
    
    @State var isFinished = false
    @State var isEditing = false
    
    @StateObject var wheelViewModel: WheelViewModel = WheelViewModel()
    
    var body: some View {
        VStack{
            
            Text(wheelViewModel.randomSection?.name ?? "????")
                .opacity(isFinished ? 1 : 0)
                .font(Font.system(size: 28, weight: .heavy))

            ZStack{
                Wheel(wheelViewModel: wheelViewModel)
                    .modifier(AnimatableModifierDouble(bindedValue: angle, isFinished: isFinished, completion: {
                        isFinished = true
                    }))
                    .rotationEffect(.degrees(angle))
                    .onTapGesture {

                        //Reset
                        angle = angle.truncatingRemainder(dividingBy: 360)
                        isFinished = false

                        //Set random section
                        guard let section = wheelViewModel.pickRandomSection() else{
                            return
                        }
                        wheelViewModel.randomSection = section

                        //Set end angle
                        let endAngle = wheelViewModel.getEndWheelAngle(randomSection: section)

                        withAnimation(self.repeatAnimation) {
                            angle = endAngle
                        }

                    }
                    .shadow(radius: 5)
                    .scaledToFit()
                    .scaleEffect(x: 0.8, y: 0.8)
                Pointer()
                    .stroke(lineWidth: 4)
                    
                    .foregroundColor(Color.red)
               
            }
            .scaledToFit()
            
            
            Text("Tap the Wheel to roll!")
            Button("Edit wheel", action: {
                isEditing = true
            })
                .scaledToFit()
                .buttonStyle(.bordered)
                
        }
        
        .onAppear{
            angle = wheelViewModel.pointerLocation.rawValue
        }
        .sheet(isPresented: $isEditing) {
            
            SectionEditor(sectionEditViewModel: SectionEditViewModel(sections: wheelViewModel.sections), wheelViewModel: wheelViewModel)
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

enum PointerLocation: Double{
    case top = 270
    case right = 0
    case bottom = 90
    case left = 180
}

struct AnimatableModifierDouble: AnimatableModifier {

    var targetValue: Double

    // SwiftUI gradually varies it from old value to the new value
    var animatableData: Double {
        didSet {
            checkIfFinished()
        }
    }

    var completion: () -> ()
    var isFinished: Bool

    // Re-created every time the control argument changes
    init(bindedValue: Double, isFinished: Bool, completion: @escaping () -> ()) {
        self.completion = completion

        // Set animatableData to the new value. But SwiftUI again directly
        // and gradually varies the value while the body
        // is being called to animate. Following line serves the purpose of
        // associating the extenal argument with the animatableData.
        self.animatableData = bindedValue
        self.isFinished = isFinished
        targetValue = bindedValue
    }

    func checkIfFinished() -> () {
        //print("Current value: \(animatableData)")
        if (animatableData.rounded(.down) == targetValue.rounded(.down) && !isFinished) {
            //if animatableData.isEqual(to: targetValue) {
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }

    // Called after each gradual change in animatableData to allow the
    // modifier to animate
    func body(content: Content) -> some View {
        // content is the view on which .modifier is applied
        content
        // We don't want the system also to
        // implicitly animate default system animatons it each time we set it. It will also cancel
        // out other implicit animations now present on the content.
            .animation(nil)
    }
}
