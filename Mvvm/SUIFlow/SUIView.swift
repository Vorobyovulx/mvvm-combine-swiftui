//
//  SUIView.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import Foundation
import SwiftUI
import UIKit

struct SUIView: View {
    
    @ObservedObject var model: WorkingDayViewModel

    var body: some View {
        switch model.state {
        case .loading:
            LoadingFullScreenView()

        case .ready:
            VStack(alignment: .leading){
                Text("Производственный календарь")
                    .font(.title3)

                TextField("YYYYMMDD", text: self.$model.inputDate)
                    .autocapitalization(.words)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                    .accentColor(.blue)

                Text(model.currentDayType.title)
                    .font(.title3)
                    .padding(.top, 20)

                Spacer()
            }
            .font(.title)
            .padding()
        }
    }
}

struct LoadingFullScreenView: View {

   var body: some View {
      VStack {
         Spacer()
         ActivityIndicator(isAnimating: .constant(true), style: .medium)
         Spacer()
      }
   }

}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }

}
