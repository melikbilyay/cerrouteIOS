import Foundation

   struct Course: Codable, Identifiable {
       let id: Int? // Make id optional
       let egitimId: Int
       let baslik: String
       let aciklama: String
       let egitmenAdi: String
       let kapakFotoUrl: String
       let date: Date?
       let kategori: String
   }
