import SwiftUI

struct GroupedSMSView: View {
    @EnvironmentObject var viewModel: SMSListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("加载中...")
                } else {
                    if viewModel.groups.isEmpty {
                        emptyStateView
                    } else {
                        List {
                            ForEach(viewModel.groups) { group in
                                NavigationLink(destination: GroupDetailView(group: group)) {
                                    GroupRow(group: group)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("分组短信")
        }
    }
    
    var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "folder.badge.questionmark")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            Text("暂无分组")
                .font(.title2)
                .foregroundColor(.secondary)
            Text("请在规则设置中创建分组规则")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct GroupRow: View {
    let group: SMSGroup
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color(hex: group.color))
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(group.name)
                    .font(.headline)
                Text("\(group.messageCount) 条短信")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct GroupDetailView: View {
    let group: SMSGroup
    @EnvironmentObject var viewModel: SMSListViewModel
    
    var body: some View {
        VStack {
            let groupMessages = viewModel.getMessages(for: group)
            
            if groupMessages.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "tray")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                    Text("该分组暂无短信")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding()
            } else {
                List {
                    ForEach(groupMessages) { message in
                        MessageRow(message: message)
                    }
                }
            }
        }
        .navigationTitle(group.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}