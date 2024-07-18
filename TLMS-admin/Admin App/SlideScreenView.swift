import SwiftUI
import AVKit

struct SlideScreenView: View {
    static let url = Bundle.main.url(forResource: "backgroundfile", withExtension: "m4v")!
    @State private var avplayer: AVPlayer
    @State private var isNavigating = false
    init() {
        avplayer = AVPlayer(url: SlideScreenView.url)
    }
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom) {
                VideoPlayer(player: avplayer)
                    .onAppear {
                        // Optionally add a delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            avplayer.play()
                        }
                        
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: avplayer.currentItem,
                            queue: .main
                        ) { _ in
                            avplayer.seek(to: .zero)
                            avplayer.play()
                        }
                    }
                    
                
                VStack {
                    Spacer()
                    TabView {
                        Image("png1") // Replace with your image name
                            .resizable() // Make the image resizable
                            .scaledToFit() // Scale the image to fill the view
                        Image("png2")
                            .resizable() // Make the image resizable
                            .scaledToFit()
                        ZStack(alignment: .bottom){
                            Image("png3")
                                .resizable() // Make the image resizable
                                .scaledToFit()
                            NavigationLink(destination: LoginScreen(), isActive: $isNavigating) {
                                CustomButton(label: "Welcome", action: {
                                    isNavigating = true
                                })
                            }
                        }
                       
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                }
                
                .padding(.top,40)

                .navigationBarBackButtonHidden(true)
                }
            .ignoresSafeArea()
            .onDisappear {
                NotificationCenter.default.removeObserver(
                    self,
                    name: .AVPlayerItemDidPlayToEndTime,
                    object: avplayer.currentItem
                )
            }
            
        }
        
              }
          }

          #Preview {
              SlideScreenView()
          }


//import SwiftUI
//import AVKit
//
//struct SlideScreenView: View {
//    @State private var avplayer: AVPlayer?
//    @State private var isNavigating = false
//
//    init() {
//        if let url = Bundle.main.url(forResource: "backgroundfile", withExtension: "m4v") {
//            avplayer = AVPlayer(url: url)
//        } else {
//            print("Error: Video file not found.")
//        }
//    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .bottom) {
//                if let avplayer = avplayer {
//                    VideoPlayer(player: avplayer)
//                        .onAppear {
//                            // Optionally add a delay
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                avplayer.play()
//                            }
//                            
//                            NotificationCenter.default.addObserver(
//                                forName: .AVPlayerItemDidPlayToEndTime,
//                                object: avplayer.currentItem,
//                                queue: .main
//                            ) { _ in
//                                avplayer.seek(to: .zero)
//                                avplayer.play()
//                            }
//                        }
//                } else {
//                    Text("Video not available")
//                }
//                
//                VStack {
//                    Spacer()
//                    TabView {
//                        Image("png1") // Replace with your image name
//                            .resizable() // Make the image resizable
//                            .scaledToFit() // Scale the image to fill the view
//                        Image("png2")
//                            .resizable() // Make the image resizable
//                            .scaledToFit()
//                        ZStack(alignment: .bottom) {
//                            Image("png3")
//                                .resizable() // Make the image resizable
//                                .scaledToFit()
//                            NavigationLink(destination: LoginScreen(), isActive: $isNavigating) {
//                                CustomButton(label: "Welcome", action: {
//                                    isNavigating = true
//                                })
//                            }
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle())
//                }
//                .padding(.top, 40)
//                .navigationBarBackButtonHidden(true)
//            }
//            .ignoresSafeArea()
//            .onDisappear {
//                if let avplayer = avplayer {
//                    NotificationCenter.default.removeObserver(
//                        self,
//                        name: .AVPlayerItemDidPlayToEndTime,
//                        object: avplayer.currentItem
//                    )
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    SlideScreenView()
//}
