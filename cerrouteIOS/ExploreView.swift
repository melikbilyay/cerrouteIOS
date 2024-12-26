import SwiftUI

struct ExploreView: View {
    @State private var courses: [Course] = [] // State variable to hold courses
    @State private var selectedCategory: String = "All" // State variable for selected category
    @State private var searchText: String = ""
    
    private let courseService = CourseService() // Instance of CourseService

    // Define categories with corresponding SF Symbols
    private let categories: [(String, String)] = [
        ("All", "star"),
        ("Programming", "laptopcomputer"),
        ("Design", "paintbrush"),
        ("Marketing", "megaphone"),
        ("Business", "briefcase"),
        ("Computer Science", "desktopcomputer")
    ]

    // Image cache
    @State private var imageCache: [String: Image] = [:] // Cache for images

    var body: some View {
        ScrollView {
            VStack(spacing: 20) { // Increased spacing between cards
                
                // Search Bar
                HStack {
                    TextField("Search Courses", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {
                        // Action for search button if needed
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                    }
                }

                // Category Picker with SF Symbols
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(categories, id: \.0) { category in
                            Button(action: {
                                selectedCategory = category.0 // Update selected category
                            }) {
                                HStack {
                                    Image(systemName: category.1) // SF Symbol
                                        .font(.title2)
                                    Text(category.0) // Category name
                                        .fontWeight(.semibold)
                                }
                                .padding()
                                .background(selectedCategory == category.0 ? Color.blue : Color.white) // Change background color based on selection
                                .foregroundColor(selectedCategory == category.0 ? Color.white : Color.blue) // Change text color based on selection
                                .cornerRadius(20) // More rounded corners
                                .shadow(color: selectedCategory == category.0 ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow effect
                                .scaleEffect(selectedCategory == category.0 ? 1.05 : 1.0) // Slightly scale up the selected button
                                .animation(.easeInOut, value: selectedCategory) // Animation for scaling
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Filtered courses based on selected category and search text
                ForEach(filteredCourses) { course in
                    CardView(course: course, imageCache: $imageCache) // Pass the image cache to CardView
                }
            }
            .padding() // Padding around the VStack
        }
        .background(Color(.systemGray6)) // Light gray background for the entire view
        .onAppear {
            fetchCourses() // Fetch courses when the view appears
        }
    }

    private var filteredCourses: [Course] {
        courses.filter { course in
            (selectedCategory == "All" || course.kategori == selectedCategory) &&
            (searchText.isEmpty || course.baslik.localizedCaseInsensitiveContains(searchText))
        }
    }

    private func fetchCourses() {
        courseService.fetchCourses { result in
            switch result {
            case .success(let fetchedCourses):
                DispatchQueue.main.async {
                    self.courses = fetchedCourses // Update state on the main thread
                }
            case .failure(let error):
                print("Error fetching courses: \(error)") // Handle error appropriately
            }
        }
    }
}

// Custom view for displaying course information
struct CardView: View {
    let course: Course
    @Binding var imageCache: [String: Image] // Binding to the image cache

    var body: some View {
        VStack(alignment: .leading) {
            // Load the cover image
            if let cachedImage = imageCache[course.kapakFotoUrl] {
                cachedImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200) // Set a fixed height for the image
                    .cornerRadius(12) // Rounded corners for the image
                    .shadow(radius: 5) // Shadow for the image
            } else {
                AsyncImage(url: URL(string: course.kapakFotoUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200) // Set a fixed height for the image
                        .cornerRadius(12) // Rounded corners for the image
                        .shadow(radius: 5) // Shadow for the image
                        .onAppear {
                            // Cache the image
                            imageCache[course.kapakFotoUrl] = image
                        }
                } placeholder: {
                    ProgressView() // Show a loading indicator while the image loads
                }
            }
            
            Text(course.baslik) // Display course title
                .font(.title2) // Larger font for the title
                .fontWeight(.bold) // Bold font weight
                .padding(.top, 5)

            Text(course.aciklama) // Display course description
                .font(.body) // Body font for description
                .foregroundColor(.gray)

            Text("Instructor: \(course.egitmenAdi)") // Display instructor's name
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(.top, 2)
        }
        .padding()
        .background(Color.white) // White background for the card
        .cornerRadius(12) // Rounded corners for the card
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Subtle shadow for the card
        .padding(.horizontal) // Horizontal padding for the card
    }
}

// Preview for ExploreView
struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .previewDevice("iPhone 14") // Specify the device for the preview
            .preferredColorScheme(.light) // Set the color scheme
    }
}
