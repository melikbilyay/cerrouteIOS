import Foundation



class CourseService {
    func fetchCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/cerroute/api/cerroute/getCourses") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Adjust based on your API's date format
                let courses = try decoder.decode([Course].self, from: data)
                completion(.success(courses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
