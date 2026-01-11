import SwiftUI

struct SMSListView: View {
    @EnvironmentObject var viewModel: SMSListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("加载中...")
                } else {
                    List {
                        Section("未分组短信") {
                            if viewModel.ungroupedMessages.isEmpty {
                                Text("暂无未分组短信")
                                    .foregroundColor(.secondary)
                            } else {
                                ForEach(viewModel.ungroupedMessages) { message in
                                    MessageRow(message: message)
                                }
                            }
                        }
                        
                        Section("所有短信 (\(viewModel.messages.count))") {
                            ForEach(viewModel.messages) { message in
                                MessageRow(message: message)
                            }
                        }
                    }
                    .refreshable {
                        viewModel.refreshMessages()
                    }
                }
            }
            .navigationTitle("短信列表")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.refreshMessages()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}

struct MessageRow: View {
    let message: SMSMessage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(message.sender)
                    .font(.headline)
                Spacer()
                Text(message.date, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Text(message.content)
                .font(.body)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}