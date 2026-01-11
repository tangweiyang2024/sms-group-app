import Foundation

enum MatchType: String, CaseIterable, Codable {
    case keyword = "关键字"
    case regex = "正则表达式"
    case sender = "发件人"
}

struct GroupRule: Identifiable, Codable {
    let id: UUID
    var groupName: String
    var matchType: MatchType
    var patterns: [String]
    var priority: Int
    var isEnabled: Bool
    var color: String
    
    init(id: UUID = UUID(), groupName: String, matchType: MatchType, patterns: [String], priority: Int = 0, isEnabled: Bool = true, color: String = "#007AFF") {
        self.id = id
        self.groupName = groupName
        self.matchType = matchType
        self.patterns = patterns
        self.priority = priority
        self.isEnabled = isEnabled
        self.color = color
    }
}