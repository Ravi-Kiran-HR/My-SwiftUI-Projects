//
//  OnboardingView.swift
//  Restart
//
//  Created by Ravi Kiran HR on 28/06/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                // MARK:  -Header
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .transition(.opacity)
                    
                    Text("""
                        Its not how much we give but
                        how much love we put into giving
                        """)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }//: Header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -100)
                .animation(.easeInOut(duration: 1), value: isAnimating)
                
                // MARK: - Center
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width) / 5)
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(imageOffset.width / 20 ))
                        .gesture(
                         DragGesture()
                                .onChanged { value in
                                    if abs(imageOffset.width) <= 150 {
                                        self.imageOffset = value.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                         
                            .onEnded { value in
                                imageOffset = .zero
                                
                                withAnimation(.linear(duration: 0.25)) {
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                }
                            }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//: Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundStyle(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                // MARK: - Footer
                
                ZStack {
                    // Parts of the custom button
                    // 1.MARK: -  Background (Static)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2.MARK: -  Call-To-Action (Static)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    // 3.MARK: -  Capsule (Dynamic Width)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    // 4.MARK: -  Circle (Draggable)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.width > 0 &&
                                        buttonOffset <= buttonWidth - 80 {
                                        self.buttonOffset = value.translation.width
                                    }
                                }
                                .onEnded { value in
                                    withAnimation(.easeOut(duration: 120)) {
                                        if value.translation.width < buttonWidth / 2 {
                                            buttonOffset = 0
                                            hapticFeedback.notificationOccurred(.warning)
                                        } else {
                                            hapticFeedback.notificationOccurred(.success)
                                            playAudio(sound: "chimeup")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }
                                    }
                                }
                        )
                        
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 100)
                .animation(.easeInOut(duration: 1), value: isAnimating)
            }
        } //: VStack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }//: ZStack
        
}

#Preview {
    OnboardingView()
}
