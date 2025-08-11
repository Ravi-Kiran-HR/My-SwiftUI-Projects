//
//  MotionAnimationView.swift
//  Hike
//
//  Created by Ravi Kiran HR on 18/06/25.
//

import SwiftUI

struct MotionAnimationView: View {
    @State private var randomCircle: Int = Int.random(in: 6...12)
    @State private var isAnimting: Bool = false
    
    // MARK: - FUNCTIONS
    
    // 1.RANDOM COORDINATE
    func randomCoordinate() -> CGFloat {
        CGFloat.random(in: 0...256)
    }
    
    // 2.RANDOM SIZE
    func randomSize() -> CGFloat {
        CGFloat.random(in: 4...80)
    }
    
    // 3.RANDOM SCALE
    func randomScale() -> CGFloat {
        CGFloat.random(in: 0.1...2.0)
    }
    // 4.RANDOM SPEED
    func randomSpeed() -> Double {
        Double.random(in: 0.05...1.0)
    }
    // 5.RANDOM DELAY
    func randomDelay() -> Double {
        Double.random(in: 0...2)
    }
    
    
    
    var body: some View {
        ZStack {
            ForEach(0...randomCircle, id: \.self) { item in
                Circle()
                    .foregroundColor(.white)
                    .opacity(0.25)
                    .frame(width: randomSize())
                    .position(x: randomCoordinate(),
                              y: randomCoordinate()
                    )
                    .scaleEffect(isAnimting ? randomScale() : 1)
                    .onAppear(perform: {
                        withAnimation (
                            .interpolatingSpring(stiffness: 0.25, damping: 0.25)
                            .repeatForever()
                            .speed(randomSpeed())
                            .delay(randomDelay())
                        ) {
                            isAnimting = true
                        }
                    })
            }
        }
        .frame(width: 256, height: 256)
        .mask(Circle())
        .drawingGroup()
    }
}


#Preview {
    MotionAnimationView()
        .background(
            Circle()
                .fill(.teal)
        )

}
