import Foundation
import SwiftUI

class RuleEditorViewModel: ObservableObject {
    @Published var groupName: String = ""
    @Published var selectedMatchType: MatchType = .keyword
    @Published var patterns: [String] = []
    @Published var newPattern: String = ""
    @Published var selectedColor: String = "#007AFF"
    @Published var priority: Int = 0
    @Published var testText: String = ""
    @Published var testResult: Bool? = nil
    @Published var isEditing = false
    @Published var editingRule: GroupRule?
    
    let colors = ["#007AFF", "#FF3B30", "#FFCC00", "#4CD964", "#5856D6", "#FF2D55", "#8E8E93", "#C7C7CC"]
    
    func resetForm() {
        groupName = ""
        selectedMatchType = .keyword
        patterns = []
        newPattern = ""
        selectedColor = "#007AFF"
        priority = 0
        testText = ""
        testResult = nil
        isEditing = false
        editingRule = nil
    }
    
    func loadRule(_ rule: GroupRule) {
        isEditing = true
        editingRule = rule
        groupName = rule.groupName
        selectedMatchType = rule.matchType
        patterns = rule.patterns
        selectedColor = rule.color
        priority = rule.priority
    }
    
    func addPattern() {
        let trimmedPattern = newPattern.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedPattern.isEmpty {
            patterns.append(trimmedPattern)
            newPattern = ""
        }
    }
    
    func removePattern(at index: Int) {
        patterns.remove(at: index)
    }
    
    func testRule() {
        guard !groupName.isEmpty && !patterns.isEmpty else {
            testResult = nil
            return
        }
        
        let testRule = GroupRule(
            groupName: groupName,
            matchType: selectedMatchType,
            patterns: patterns,
            priority: priority,
            color: selectedColor
        )
        
        testResult = GroupingEngine.shared.testRule(rule: testRule, testText: testText)
    }
    
    func saveRule() -> GroupRule? {
        guard !groupName.isEmpty && !patterns.isEmpty else {
            return nil
        }
        
        let rule = GroupRule(
            id: editingRule?.id ?? UUID(),
            groupName: groupName,
            matchType: selectedMatchType,
            patterns: patterns,
            priority: priority,
            color: selectedColor
        )
        
        return rule
    }
    
    func isFormValid() -> Bool {
        !groupName.isEmpty && !patterns.isEmpty
    }
}