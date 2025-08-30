//
//  ContentView.swift
//  Pinch
//
//  Created by Ravi Kiran HR on 28/08/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: -- PROPERTY --
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen = false
    
    let pages: [Page] = pageData
    @State private var pageIndex: Int = 1
    
    var currentPage: String {
        return pages[pageIndex - 1].imageName
    }
    
    // MARK: -- FUNCTION --
    func resetImageState() {
        withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    // MARK: -- CONTENT --
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                Image(currentPage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .offset(imageOffset)
                
                // MARK: -- TAP GESTURE
                    .onTapGesture(count: 2, perform:  {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    })
                
                // MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
                
                // MARK: - Magnification
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            .onEnded{ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        )
                
                
            } //:ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 2)) {
                    isAnimating = true
                }
            }
            // MARK: - Info panel
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30), alignment: .top)
            
            // MARK: - Controls
            .overlay(
                Group {
                    HStack {
                        // Sclae down
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        // Reset
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // Sclae Up
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                }
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    } // Controls
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.bottom, 30), alignment: .bottom)
            
            // MARK: - Drawer
            .overlay (
                HStack(spacing: 12)  {
                    // MARK: - Drawer handle
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        }
                    
                    // MARK: - Thumbnails
                    ForEach(pages) { item in
                        Image(item.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture {
                                isAnimating = true
                                pageIndex = item.id
                            }
                    }
                    
                    Spacer()
                }// drawer
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                , alignment: .topTrailing)
            
        } //:NavigationView
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
