//
//  LaunchScreenHelpView.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/24/23.
//

import SwiftUI

struct LaunchScreenHelpView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                        Text("Email requirements:")
                            .font(.title2)
                            .bold()
                    }

                    Text("1. The email should contain a username followed by '@' and a domain name.")
                    Text("2. The username can contain letters, numbers, and special characters such as '.', '_', '%', '+', '-'.")
                    
                    Text("NOTE: the username part of your email will become your AMS username. When logging in, make sure to use the email and not username")
                        .bold()

                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                        Text("Password requirements:")
                            .font(.title2)
                            .bold()
                    }

                    Text("1. Minimum 8 characters long.")
                    Text("2. At least one uppercase letter.")
                    Text("3. At least one lowercase letter.")
                    Text("4. At least one digit.")
                    Text("5. At least one special character (e.g., @, $, !, %, *, ?, &).")

                }
                .padding()
            }
            .navigationBarTitle("Help", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                dismiss()
            })
            .background(Color("launchScreenColor").opacity(0.8))
            .foregroundColor(.accentColor)
            
        }
        .font(.lovelo()
        )
        
    }
}



struct LaunchScreenHelpView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenHelpView()
    }
}
