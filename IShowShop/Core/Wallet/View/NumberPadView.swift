//
//  NumberPadView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import SwiftUI

struct NumberPadView: View {
    
    @StateObject var viewModel: WalletViewModel
    @Environment (\.dismiss) var dismiss
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: WalletViewModel(user: user))
    }
    
    let columns: [GridItem] = [
        .init(),
        .init(),
        .init()
    ]
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(Color(.systemGray6))
                .background(Color(.systemGray6))
                .overlay(
                    Text(viewModel.inputtedNumbers)
                        .font(.title)
                        .foregroundStyle(.black)
                )
                .padding()
            
            LazyVGrid(columns: columns) {
                ForEach(1 ... 9, id: \.self) { index in
                    Button {
                        viewModel.inputtedNumbers.append("\(index)")
                    } label: {
                        Text("\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .contentShape(Rectangle())
                    }
                }
                
                Button {
                    viewModel.inputtedNumbers = ""
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .contentShape(Rectangle())
                }
                
                Button {
                    viewModel.inputtedNumbers.append("0")
                } label: {
                    Text("0")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .contentShape(Rectangle())
                }
                
                Button {
                    viewModel.inputtedNumbers = String(viewModel.inputtedNumbers.dropLast())
                } label: {
                    Image(systemName: "delete.backward")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .contentShape(Rectangle())
                }
            }
            .foregroundStyle(.primary)
            
            Button {
                Task {
                    try await viewModel.topUpBalance(value: viewModel.inputtedNumbers, user: viewModel.user)
                    dismiss()
                    try await AuthService.shared.loadUserData()
                }
            } label: {
                Text("Top Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 44)
                    .background(Constant.mainColor)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
        }
    }
}


#Preview {
    NumberPadView(user: User.MOCK_USER[0])
}
