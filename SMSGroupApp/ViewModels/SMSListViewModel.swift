import Foundation
import Combine

class SMSListViewModel: ObservableObject {
    @Published var messages: [SMSMessage] = []
    @Published var groups: [SMSGroup] = []
    @Published var rules: [GroupRule] = []
    @Published var ungroupedMessages: [SMSMessage] = []
    @Published var isLoading = false
    
    private let smsService = SMSService.shared
    private let groupingEngine = GroupingEngine.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadDefaultRules()
        loadMessages()
    }
    
    func loadMessages() {
        isLoading = true
        
        DispatchQueue.global(qos: .background).async {
            let fetchedMessages = self.smsService.fetchAllMessages()
            
            DispatchQueue.main.async {
                self.messages = fetchedMessages
                self.processGrouping()
                self.isLoading = false
            }
        }
    }
    
    private func processGrouping() {
        var groupedMessages: [UUID: [SMSMessage]] = [:]
        var groupedIds: Set<UUID> = []
        
        for message in messages {
            if let groupId = groupingEngine.processMessage(message, with: rules) {
                if groupedMessages[groupId] == nil {
                    groupedMessages[groupId] = []
                }
                groupedMessages[groupId]?.append(message)
                groupedIds.insert(message.id)
            }
        }
        
        ungroupedMessages = messages.filter { !groupedIds.contains($0.id) }
        
        groups = rules.map { rule in
            let groupMessages = groupedMessages[rule.id] ?? []
            return SMSGroup(
                id: rule.id,
                name: rule.groupName,
                messageIds: groupMessages.map { $0.id },
                ruleId: rule.id,
                color: rule.color,
                messageCount: groupMessages.count
            )
        }.filter { $0.messageCount > 0 }
    }
    
    private func loadDefaultRules() {
        rules = [
            GroupRule(
                groupName: "银行通知",
                matchType: .keyword,
                patterns: ["银行", "账户", "余额", "支出", "收入"],
                priority: 1,
                color: "#FF3B30"
            ),
            GroupRule(
                groupName: "快递通知",
                matchType: .keyword,
                patterns: ["快递", "物流", "取件", "菜鸟"],
                priority: 2,
                color: "#FFCC00"
            ),
            GroupRule(
                groupName: "验证码",
                matchType: .regex,
                patterns: [@"\d{6}", @"验证码"],
                priority: 3,
                color: "#4CD964"
            ),
            GroupRule(
                groupName: "运营商",
                matchType: .sender,
                patterns: ["10086", "10010", "10000"],
                priority: 4,
                color: "#007AFF"
            )
        ]
    }
    
    func addRule(_ rule: GroupRule) {
        rules.append(rule)
        processGrouping()
    }
    
    func updateRule(_ rule: GroupRule) {
        if let index = rules.firstIndex(where: { $0.id == rule.id }) {
            rules[index] = rule
            processGrouping()
        }
    }
    
    func deleteRule(_ rule: GroupRule) {
        rules.removeAll { $0.id == rule.id }
        processGrouping()
    }
    
    func refreshMessages() {
        loadMessages()
    }
    
    func getMessages(for group: SMSGroup) -> [SMSMessage] {
        return messages.filter { group.messageIds.contains($0.id) }
    }
}