//
//  SettingsView.swift
//  Hike
//
//  Created by Ravi Kiran HR on 18/06/25.
//

import SwiftUI

struct SettingsView: View {
    
    private let alternateAppIcons: [String] = [
        "AppIcon-Backpack",
        "AppIcon-Camera",
        "AppIcon-Campfire",
        "AppIcon-MagnifyingGlass",
        "AppIcon-Map",
        "AppIcon-Mushroom"
    ]
    
    var body: some View {
        List {
            Section {
                // Section Header
                HStack {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 80, weight: .black))
                    
                    VStack(spacing: -10) {
                        Text("Hike")
                            .font(.system(size: 66, weight: .black))
                        
                        Text("Editor's Choice")
                            .fontWeight(.medium)
                    }
                    
                    Image(systemName: "laurel.trailing")
                        .font(.system(size: 80, weight: .black))
                    Spacer()
                }
                .foregroundStyle(
                    LinearGradient(
                        colors:[
                            .customGreenLight,
                            .customGreenMedium,
                            .customGreenDark
                        ],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .padding(.top, 8)
                
                VStack(spacing: 8) {
                    Text("Where can you find \nperfect tracks?")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Text("The hike which looks gorgeous in photos but is even better once your are actually there. The hike that you hope to do again someday. \nFind the best day hikes in the app.")
                        .font(.footnote)
                        .italic()
                    
                    Text("Dust off the boots! It's time for a walk.")
                        .fontWeight(.heavy)
                        .foregroundColor(.customGreenMedium)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
            } //: End of Header
            .listRowSeparator(.hidden)
            
            // Section Icons
            Section(header: Text("Alternate Icons")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(alternateAppIcons.indices, id: \.self) { index in
                            Button {
                                print("\(alternateAppIcons[index]) icon pressed")
                                UIApplication.shared.setAlternateIconName(alternateAppIcons[index]) { error in
                                    if let error = error {
                                        print("Error setting alternate icon: \(error.localizedDescription)")
                                    } else {
                                        print("\(alternateAppIcons[index]) -  alternate icon set successfully")
                                    }
                                }
                            } label: {
                                Image("\(alternateAppIcons[index])-Preview")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .scaledToFit()
                                    .cornerRadius(16)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                } //: Scroll View
                .padding(.top, 12)
                
                Text("Choose your favorite app icon from the collection above")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .padding(.bottom, 12)
                
            } //: SECTION ICONS
            .listRowSeparator(.hidden)
            
            //Section About
            Section(
                header: Text("ABOUT THE APP"),
                footer: HStack {
                    Spacer()
                    Text("Copyright © 2025. All right reserved")
                    Spacer()
                        
                }
                    .padding(.vertical, 8)
            ) {
                // 1. Basic labeled content
                // LabeledContent("Application", value: "Hike")
                
                // 2. advance labelled content
                CustomListRowView(rowLabel: "Application",
                                  rowIcon: "apps.iphone",
                                  rowContent: "HIKE",
                                  rowTintColor: .blue)
                
                CustomListRowView(rowLabel: "Compatibility",
                                  rowIcon: "info.circle",
                                  rowContent: "iOS",
                                  rowTintColor: .red)
                
                CustomListRowView(rowLabel: "Technology",
                                  rowIcon: "swift",
                                  rowContent: "Swift",
                                  rowTintColor: .orange)
                
                CustomListRowView(rowLabel: "Version",
                                  rowIcon: "gear",
                                  rowContent: "1.0",
                                  rowTintColor: .gray)
                
                CustomListRowView(rowLabel: "Developer",
                                  rowIcon: "ellipsis.curlybraces",
                                  rowContent: "Ravi Kiran HR",
                                  rowTintColor: .purple)
                
                CustomListRowView(rowLabel: "Designer",
                                  rowIcon: "paintpalette",
                                  rowContent: "Robert Petras",
                                  rowTintColor: .indigo)
                
                CustomListRowView(rowLabel: "Website",
                                  rowIcon: "globe",
                                  rowContent: nil,
                                  rowTintColor: .purple,
                                  rowLinkLabel: "Credo Academy",
                                  rowLinkDestination: "https://credo.academy")
                    
            }//: Section
            
        } // :List
    }
}

#Preview {
    SettingsView()
}
