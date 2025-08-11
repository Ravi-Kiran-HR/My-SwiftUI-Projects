//
//  HomeView.swift
//  Restart
//
//  Created by Ravi Kiran HR on 28/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Header
            
            Spacer()
            
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.15)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 80 : -80)
                    .animation(
                        .easeOut(duration: 2)
                        .repeatForever()
                        , value : isAnimating
                    )
            }
            
            // MARK: - Center
            Spacer()
            Text("The time that leads to mastery is dependent on the intensity of your focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - Footer
            
            Spacer()
            
            Button {
                withAnimation {
                    playAudio(sound: "success", type: "m4a")
                    isOnboardingViewActive = true
                }
            } label: {
                Image(systemName:"arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }//: Vstack
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    HomeView()
}
