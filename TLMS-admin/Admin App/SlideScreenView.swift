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
        NavigationView {
            ZStack(alignment: .bottom) {

               

                
                VStack {
                    Spacer()
                    TabView {
                        Image("png1") // Replace with your image name
                            .resizable() // Make the image resizable
                            .scaledToFit() // Scale the image to fill the view
                            .background(Color("imageBackground").ignoresSafeArea())
                        
                        Image("png2")
                            .resizable() // Make the image resizable
                            .scaledToFit()
                            .background(Color("imageBackground").ignoresSafeArea())
                        
                        ZStack(alignment: .bottom) {
                            Image("png3")
                                .resizable() // Make the image resizable
                                .scaledToFit()
                                .background(Color("imageBackground").ignoresSafeArea())
                            
                            NavigationLink(destination: LoginScreen(), isActive: $isNavigating) {
                                CustomButton(label: "Welcome", action: {
                                    isNavigating = true
                                })
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
                .padding(.top, 40)
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

          #Preview {
              SlideScreenView()
          }


