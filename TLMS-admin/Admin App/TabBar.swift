import SwiftUI

struct TabBar: View {
    @State private var selectedTabIndex = 1 // Default to CoursesView (index 1)
    var target : String
//    var course: Course
    
    var body: some View {
        
            VStack {
                CustomTabBarAppearance() // Apply custom tab bar appearance
                    .frame(height: 0) // Hide the actual tab bar
                    .hidden()
                
                TabView(selection: $selectedTabIndex) {
                    NavigationStack{
                        NotificationView()}
                        .tabItem {
                            Image(systemName: "bell")
                            Text("Notification")
                        }
                        .tag(0) // Tag for NotificationView
                    NavigationStack{
                        CoursesView(selectedTarget: target)}
                        .tabItem {
                            Image(systemName: "book")
                            Text("Courses")
                        }
                        .tag(1) // Tag for CoursesView
                    NavigationStack{
                        EducatorListView()}
                        .tabItem {
                            Image(systemName: "person.3.fill")
                            Text("Educators")
                        }
                        .tag(2) // Tag for ProfileView
                    NavigationStack{
                        StatsView()}
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis")
                            Text("Account")
                        }
                        .tag(3)
                
               
                .navigationBarBackButtonHidden(true)}
            
        }
        
        .navigationBarHidden(true)
    }
    }


struct CustomTabBarAppearance: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white

        // Customize tab bar item colors
        let itemAppearance = UITabBarItemAppearance()
        let selectedColor = UIColor( Color(hex: "#6C5DD4") ?? Color(.black))
        let normalColor = UIColor(Color(hex: "#6C5DD4")?.opacity(0.7) ?? Color(.black))

        itemAppearance.normal.iconColor = normalColor
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
        itemAppearance.selected.iconColor = selectedColor
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        tabBarAppearance.stackedLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No update needed
    }
}

//struct NotificationView: View {
//    var body: some View {
//        Text("Notifications")
//    }
//}

struct ProfileView: View {
    var body: some View {
        Text("Educators")
    }
}
//#Preview {
//    TabBar(target: "HAHA! ")
//}
