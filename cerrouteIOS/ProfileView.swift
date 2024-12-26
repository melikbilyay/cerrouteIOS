//
//  ProfileView.swift
//  cerrouteIOS
//
//  Created by Melik Bilyay on 1.12.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var userName: String = "John Doe"
    @State private var userEmail: String = "john.doe@example.com"
    @State private var profileImage: Image = Image(systemName: "person.circle.fill")

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header with background image
                ZStack {
                    Image("profile_background")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()

                    profileImage
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .offset(y: 50)
                }
                .frame(height: 150)
                .padding(.bottom, 90)

                // User Information
                VStack(spacing: 10) {
                    Text(userName)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.brandDark)

                    Text(userEmail)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button(action: {
                        // Action for editing profile
                    }) {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .foregroundColor(.brandAccent)
                    }

                    Divider().padding(.vertical)

                    // User Statistics
                    HStack {
                        VStack {
                            Text("Courses")
                                .font(.headline)
                            Text("12")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        VStack {
                            Text("Hours")
                                .font(.headline)
                            Text("48")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        VStack {
                            Text("Achievements")
                                .font(.headline)
                            Text("5")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal)

                    Divider().padding(.vertical)

                    // Recent Activities
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Activities")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)

                        ForEach(0..<3) { index in
                            HStack {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.brandAccent)
                                Text("Completed Course \(index + 1)")
                                    .font(.subheadline)
                            }
                            .padding(.horizontal)
                        }
                    }

                    Divider().padding(.vertical)

                    // Settings and Logout Buttons
                    VStack(spacing: 15) {
                        Button(action: {
                            // Action for settings
                        }) {
                            HStack {
                                Image(systemName: "gear")
                                    .foregroundStyle(Color.brandAccent)
                                Text("Settings")
                                    .font(.headline)
                                    .foregroundStyle(Color.brandAccent)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brandPrimary.opacity(0.1))
                            .cornerRadius(10)
                        }

                        Button(action: {
                            // Action for logout
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                    .foregroundStyle(Color.brandAccent)
                                Text("Logout")
                                    .font(.headline)
                                    .foregroundStyle(Color.brandAccent)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)
                .padding(.top, -40) // Adjust for profile image overlap

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
