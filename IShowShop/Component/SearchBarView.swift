//
//  SearchBarView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchBarView: View {
    let user: User
    @Binding var inputProducts: String
    @State private var showFavoriteProduct = false
    @StateObject var viewmodel = SearchViewModel()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var transcriptFinal: String = ""

    var body: some View {
        HStack {
            HStack(spacing: 15) {
                Button {
                    inputProducts = ""
                } label: {
                    Image(systemName: inputProducts == "" ? "magnifyingglass" : "xmark.circle.fill")
                }
                .foregroundStyle(Constant.textColor)
                
                TextField("Search products here", text: $inputProducts)
                
                
                Spacer()
                
                Button {
                    if !isRecording {
                        speechRecognizer.startTranscribing()
                    } else {
                        speechRecognizer.stopTranscribing()
                        transcriptFinal = speechRecognizer.transcript
                        inputProducts = transcriptFinal
                    }
                    
                    isRecording.toggle()
                } label: {
                    Image(systemName: "mic.fill")
                        .foregroundStyle(isRecording ? .red : Constant.textColor)
                }
            }
            .padding(.horizontal)
            .frame(height: 40)
            .background(Color(.systemGray5))

            Button {
                showFavoriteProduct.toggle()
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(Constant.textColor)
            }
            .fullScreenCover(isPresented: $showFavoriteProduct, content: {
                FavoriteProductView(user: user)
            })
        }
        .padding(.bottom)
        .padding(.trailing, 10)
        .onChange(of: speechRecognizer.transcript) { newTranscript in
            if isRecording {
                inputProducts = newTranscript
            }
        }
    }
}

#Preview {
    SearchBarView(user: User.MOCK_USER[0], inputProducts: .constant(""))
}

