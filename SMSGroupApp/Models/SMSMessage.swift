import Foundation
import MessageKit

struct SMSMessage: Identifiable, Codable {
    let id: UUID
    let sender: String
    let content: String
    let date: Date
    let groupId: UUID?
    
    init(id: UUID = UUID(), sender: String, content: String, date: Date, groupId: UUID? = nil) {
        self.id = id
        self.sender = sender
        self.content = content
        self.date = date
        self.groupId = groupId
    }
}