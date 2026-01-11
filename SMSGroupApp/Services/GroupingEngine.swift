import Foundation

class GroupingEngine {
    static let shared = GroupingEngine()
    
    private init() {}
    
    func processMessage(_ message: SMSMessage, with rules: [GroupRule]) -> UUID? {
        let enabledRules = rules.filter { $0.isEnabled }.sorted { $0.priority < $1.priority }
        
        for rule in enabledRules {
            if matchesRule(message, rule: rule) {
                return rule.id
            }
        }
        
        return nil
    }
    
    private func matchesRule(_ message: SMSMessage, rule: GroupRule) -> Bool {
        switch rule.matchType {
        case .keyword:
            return rule.patterns.contains { pattern in
                message.content.contains(pattern) || message.sender.contains(pattern)
            }
            
        case .regex:
            return rule.patterns.contains { pattern in
                guard let regex = try? NSRegularExpression(pattern: pattern) else {
                    return false
                }
                
                let contentRange = NSRange(message.content.startIndex..., in: message.content)
                let senderRange = NSRange(message.sender.startIndex..., in: message.sender)
                
                return regex.firstMatch(in: message.content, range: contentRange) != nil ||
                       regex.firstMatch(in: message.sender, range: senderRange) != nil
            }
            
        case .sender:
            return rule.patterns.contains(message.sender)
        }
    }
    
    func testRule(rule: GroupRule, testText: String) -> Bool {
        let testMessage = SMSMessage(sender: "测试", content: testText, date: Date())
        return matchesRule(testMessage, rule: rule)
    }
}