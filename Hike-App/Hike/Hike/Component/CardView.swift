//
//  CardView.swift
//  Hike
//
//  Created by Ravi Kiran HR on 17/06/25.
//

import SwiftUI

struct CardView: View {
    
    @State private var imageNumber: Int = 1
    @State private var randomNumber: Int = 1
    @State private var isShowingSheet: Bool = false
    
    func randomImage() {
        print("--- EXPLORE BUTTON PRESSED ---")
        print("Status: Old Image Number: \(imageNumber)")
        repeat {
            randomNumber = Int.random(in: 1...5)
            print("Action: Random Number Generated: \(randomNumber)")
        } while randomNumber == imageNumber
        imageNumber = randomNumber
        print("Result: New Image Number: \(imageNumber)")
        print("--- THE END ---")
        print("\n")
    }
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            VStack {
                // Header
                VStack(alignment: .leading) {
                    HStack {
                        Text("Hiking")
                            .font(.system(size: 52))
                            .fontWeight(.black)
                            .foregroundStyle(
                                LinearGradient(colors: [.customGrayLight,
                                                        .customGrayMedium],
                                               startPoint: .top, endPoint: .bottom)
                            )
                        Spacer()
                        Button {
                            print("button clicked")
                            isShowingSheet.toggle()
                        } label: {
                            CustomButtonView()
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            SettingsView()
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.medium, .large])
                        }
                    }
                    
                    Text("Fun and enjoyable outdoor activity for friends and families.")
                        .multilineTextAlignment(.leading)
                        .italic()
                        .foregroundColor(.customGrayMedium)
                }
                .padding(.horizontal, 30)
                // Main Content
                ZStack {
                    CustomCircleView()
                    Image("image-\(imageNumber)")
                        .resizable()
                        .scaledToFit()
                        .animation(.easeInOut(duration: 0.5), value: imageNumber)
                }
                // Footer
                Button {
                    // Generate a random number
                    randomImage()
                } label: {
                    Text("Explore More")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundStyle(
                            LinearGradient(colors: [.customGreenLight,
                                                    .customGreenMedium],
                                           startPoint: .top,
                                           endPoint: .bottom
                                          )
                        )
                        .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 4)
                }
              // custom button modifier
                .buttonStyle(GradientButtonStyle())
            }
        }
        .frame(width: 320, height: 570)
    }
}

#Preview {
    CardView()
        .padding(32)
}
