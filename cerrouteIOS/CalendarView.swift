import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date() // State variable for the current date

    var body: some View {
        VStack {
            Text(getMonthYearString(from: currentDate)) // Display current month and year
                .font(.largeTitle)
                .padding()

            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }

            let daysInMonth = getDaysInMonth(for: currentDate)
            let firstDayOfMonth = getFirstDayOfMonth(for: currentDate)

            // Create a grid for the days of the month
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                // Empty spaces for days before the first day of the month
                ForEach(0..<firstDayOfMonth, id: \.self) { _ in
                    Text("")
                }

                // Days of the month
                ForEach(1...daysInMonth, id: \.self) { day in
                    Text("\(day)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brandAccent.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            .padding()
        }
    }

    // Helper function to get the month and year as a string
    private func getMonthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    // Helper function to get the number of days in the current month
    private func getDaysInMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }

    // Helper function to get the first day of the month
    private func getFirstDayOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstDateOfMonth = calendar.date(from: components)!
        return calendar.component(.weekday, from: firstDateOfMonth) - 1 // Adjust for zero-based index
    }
}

// Preview for CalendarView
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .previewDevice("iPhone 14") // Specify the device for the preview
            .preferredColorScheme(.light) // Set the color scheme
    }
}
