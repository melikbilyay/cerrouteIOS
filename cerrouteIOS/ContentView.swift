//
//  ContentView.swift
//  cerrouteIOS
//
//  Created by Melik Bilyay on 1.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            // Main content view
            TabView(selection: $selectedTab) {
                ExploreView()
                    .tag(0)
                
                SearchView()
                    .tag(1)
                
                MyRouteView()
                    .tag(2)
                
                CalendarView()
                    .tag(3)
                
                ProfileView()
                    .tag(4)
            }
            .accentColor(.clear) // Remove default tint color

            // Custom Tab Bar with Fixed Height and Orange Background at the Bottom
            VStack {
                Spacer() // Pushes the tab bar to the bottom
                HStack {
                    ForEach(0..<5) { index in
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedTab = index
                            }
                        }) {
                            VStack {
                                // Icon with scale and rotation animation
                                Image(systemName: tabIcon(for: index))
                                    .font(.system(size: 30))
                                    .scaleEffect(selectedTab == index ? 1.3 : 1.0) // Scale when selected
                                    .foregroundColor(selectedTab == index ? .white : .brandPrimary) // White for selected icon
                                    .rotationEffect(selectedTab == index ? .degrees(360) : .degrees(0)) // Rotate when selected
                                    .frame(maxWidth: .infinity)
                                
                                // Custom Indicator under selected tab
                                if selectedTab == index {
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: 50, height: 4)
                                        .foregroundColor(.white) // Indicator color
                                        .matchedGeometryEffect(id: "indicator", in: animation)
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .padding() // Keeps the padding for the icons and indicator
                .frame(height: 80) // Fixed height for the tab bar
                .background(Color.brandDarker) // Set background color to orange
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
            .padding(.bottom, 0) // No extra padding to avoid bottom space
        }
        .edgesIgnoringSafeArea(.bottom) // Ensures the tab bar is not pushed up by safe area
    }
    
    private func tabIcon(for index: Int) -> String {
        switch index {
        case 0: return "safari"
        case 1: return "magnifyingglass"
        case 2: return "book.fill"
        case 3: return "calendar"
        case 4: return "person.circle.fill"
        default: return "app.fill"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
