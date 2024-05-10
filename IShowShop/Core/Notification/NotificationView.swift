//
//  NotificationView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0 ... 10, id: \.self) { item in
                    NotificationCell()
                }
            }
            .navigationTitle("Notifications")
        }
    }
}

#Preview {
    NotificationView()
}
