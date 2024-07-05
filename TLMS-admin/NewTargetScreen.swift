//
//  NewTarget.swift
//  tlms_target_creation
//
//  Created by Divyansh Kaushik on 04/07/24.
//

import SwiftUI

struct NewTargetScreen: View {
    @State private var textTitle: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Target")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.init(top: 0, leading: 50, bottom: 0, trailing: 0))
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                        .font(.title3)
                })
            }
            .padding()

            Divider()
                .frame(width: 385,height: 10)
            TextField("Add Target Title", text: $textTitle)
                .padding(5)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
}

#Preview {
    NewTargetScreen()
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
