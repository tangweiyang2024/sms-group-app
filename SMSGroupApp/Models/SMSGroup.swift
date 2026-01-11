import Foundation

struct SMSGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    var messageIds: [UUID]
    var ruleId: UUID
    var color: String
    var messageCount: Int
    
    init(id: UUID = UUID(), name: String, messageIds: [UUID] = [], ruleId: UUID, color: String, messageCount: Int = 0) {
        self.id = id
        self.name = name
        self.messageIds = messageIds
        self.ruleId = ruleId
        self.color = color
        self.messageCount = messageCount
    }
}