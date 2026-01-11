import SwiftUI

struct RuleListView: View {
    @EnvironmentObject var viewModel: SMSListViewModel
    @State private var showingRuleEditor = false
    @State private var editingRule: GroupRule?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.rules) { rule in
                    RuleRow(rule: rule)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            editingRule = rule
                            showingRuleEditor = true
                        }
                }
                .onDelete(perform: deleteRules)
            }
            .navigationTitle("分组规则")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editingRule = nil
                        showingRuleEditor = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingRuleEditor) {
                RuleEditorView(rule: editingRule)
                    .environmentObject(viewModel)
            }
        }
    }
    
    private func deleteRules(at offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteRule(viewModel.rules[index])
        }
    }
}

struct RuleRow: View {
    let rule: GroupRule
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color(hex: rule.color))
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(rule.groupName)
                    .font(.headline)
                
                HStack {
                    Text(rule.matchType.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(4)
                    
                    Text("\(rule.patterns.count) 个规则")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Text("\(rule.priority)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(8)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.vertical, 4)
        .opacity(rule.isEnabled ? 1.0 : 0.6)
    }
}