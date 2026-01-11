import SwiftUI

struct RuleEditorView: View {
    @EnvironmentObject var viewModel: SMSListViewModel
    @StateObject private var editorViewModel = RuleEditorViewModel()
    @Environment(\.dismiss) var dismiss
    
    let rule: GroupRule?
    
    init(rule: GroupRule? = nil) {
        self.rule = rule
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("基本信息")) {
                    TextField("分组名称", text: $editorViewModel.groupName)
                    
                    Picker("匹配类型", selection: $editorViewModel.selectedMatchType) {
                        ForEach(MatchType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    Picker("优先级", selection: $editorViewModel.priority) {
                        ForEach(0..<10) { i in
                            Text("\(i)").tag(i)
                        }
                    }
                }
                
                Section(header: Text("规则模式")) {
                    HStack {
                        TextField("输入模式", text: $editorViewModel.newPattern)
                            .onSubmit {
                                editorViewModel.addPattern()
                            }
                        
                        Button(action: {
                            editorViewModel.addPattern()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .disabled(editorViewModel.newPattern.isEmpty)
                    }
                    
                    if editorViewModel.patterns.isEmpty {
                        Text("暂无规则模式")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(Array(editorViewModel.patterns.enumerated()), id: \.offset) { index, pattern in
                            HStack {
                                Text(pattern)
                                    .font(.body)
                                Spacer()
                                Button(action: {
                                    editorViewModel.removePattern(at: index)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("颜色标识")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))]) {
                        ForEach(editorViewModel.colors, id: \.self) { color in
                            Circle()
                                .fill(Color(hex: color))
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Circle()
                                        .stroke(Color.primary, lineWidth: editorViewModel.selectedColor == color ? 2 : 0)
                                )
                                .onTapGesture {
                                    editorViewModel.selectedColor = color
                                }
                        }
                    }
                }
                
                Section(header: Text("规则测试")) {
                    TextField("输入测试文本", text: $editorViewModel.testText)
                    
                    if let result = editorViewModel.testResult {
                        HStack {
                            Image(systemName: result ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(result ? .green : .red)
                            Text(result ? "匹配成功" : "匹配失败")
                                .foregroundColor(result ? .green : .red)
                        }
                    }
                    
                    Button("测试规则") {
                        editorViewModel.testRule()
                    }
                    .disabled(editorViewModel.testText.isEmpty)
                }
            }
            .navigationTitle(rule == nil ? "新建规则" : "编辑规则")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        saveRule()
                    }
                    .disabled(!editorViewModel.isFormValid())
                }
            }
        }
        .onAppear {
            if let rule = rule {
                editorViewModel.loadRule(rule)
            }
        }
    }
    
    private func saveRule() {
        guard let newRule = editorViewModel.saveRule() else {
            return
        }
        
        if rule != nil {
            viewModel.updateRule(newRule)
        } else {
            viewModel.addRule(newRule)
        }
        
        dismiss()
    }
}