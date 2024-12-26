import Foundation
import SwiftUI

struct MyRouteView: View {
    @State private var userName: String = "Melik Bilyay"
    @State private var userCourses: [CourseProgress] = []
    private let courseService = CourseService()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Header with Gradient Background
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.brandDarker]), startPoint: .top, endPoint: .bottom)
                        .cornerRadius(15)
                        .shadow(radius: 5)

                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        
                        Text("Welcome, \(userName)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .padding(.top)

                Text("Your Courses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(userCourses) { courseProgress in
                            VStack(alignment: .leading) {
                                Text(courseProgress.course.baslik)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                ProgressView(value: courseProgress.progress, total: 1.0)
                                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                    .frame(height: 10)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(15) // More rounded corners
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Subtle shadow for card
                            .padding(.horizontal) // Padding for card
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("My Route")
            .background(Color(.systemGray6)) // Light gray background for the entire view
        }
        .onAppear {
            fetchCourses()
        }
    }

    private func fetchCourses() {
        courseService.fetchCourses { result in
            switch result {
            case .success(let fetchedCourses):
                DispatchQueue.main.async {
                    self.userCourses = fetchedCourses.map { CourseProgress(course: $0, progress: 0.0) }
                }
            case .failure(let error):
                print("Error fetching courses: \(error)")
            }
        }
    }

    static func dateFromString(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: dateString) ?? Date()
    }
}

struct CourseProgress: Identifiable {
    let id = UUID()
    let course: Course
    let progress: Double
}

struct MyRouteView_Previews: PreviewProvider {
    static var previews: some View {
        MyRouteView()
    }
}
