import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = SMSListViewModel()
    
    var body: some View {
        TabView {
            SMSListView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("短信")
                }
            
            GroupedSMSView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("分组")
                }
            
            RuleListView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("规则")
                }
        }
        .environmentObject(viewModel)
    }
}