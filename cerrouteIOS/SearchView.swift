import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var courses: [Course] = []
    private let courseService = CourseService()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar with Magnifying Glass Placeholder
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Courses", text: $searchText)
                            .padding(10)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Button(action: {
                        // Action for search button if needed
                    }) {
                        Text("Search")
                            .fontWeight(.semibold)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top)

                // Course List
                if filteredCourses.isEmpty {
                    Text("No courses found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(filteredCourses) { course in
                        CourseRow(course: course) // Use the CourseRow to display each course
                            .listRowBackground(Color.clear) // Make list row background clear
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search")
            .onAppear(perform: loadCourses)
            .background(Color(.systemGray6)) // Light gray background for the entire view
        }
    }

    private var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { $0.baslik.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func loadCourses() {
        courseService.fetchCourses { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCourses):
                    self.courses = fetchedCourses
                case .failure(let error):
                    print("Error fetching courses: \(error)")
                }
            }
        }
    }
}

// Custom view for displaying course information
struct CourseRow: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading) {
            Text(course.baslik) // Display course title
                .font(.headline)
                .foregroundColor(.primary)
            Text(course.aciklama) // Display course description
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15) // More rounded corners
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Subtle shadow for card
    }
}

// Preview for SearchView
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
