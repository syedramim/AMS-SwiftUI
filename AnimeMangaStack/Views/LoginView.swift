//
//  LoginView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/23/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonDisabled = true
    @State private var presentSheet = false
    @State private var showingHelpSheet = false
    @FocusState private var focusField: Field?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("launchScreenColor").ignoresSafeArea()
                
                VStack {
                    Image("launchscreen")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .submitLabel(.next)
                            .focused($focusField, equals: .email)
                            .onSubmit {
                                focusField = .password
                            }
                            .onChange(of: email) { _ in
                                enableButtons()
                            }
                        
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .submitLabel(.done)
                            .focused($focusField, equals: .password)
                            .onSubmit {
                                focusField = nil
                            }
                            .onChange(of: password) { _ in
                                enableButtons()
                            }
                    }
                    .font(.lovelo(20))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                    .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        Button(action: {
                            register()
                        }) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
                        }
                        .disabled(buttonDisabled)
                        
                        Button(action: {
                            login()
                        }) {
                            Text("Log In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
                        }
                        .disabled(buttonDisabled)
                    }
                    .font(.lovelo(20))
                    .padding(.horizontal)
                    .padding(.top)
                    .foregroundColor(Color("launchScreenColor"))
                    
                    
                    Spacer()
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                }
                .onAppear{
                    if Auth.auth().currentUser != nil {
                        print("Login successful!")
                        presentSheet = true
                    }
                }
                .fullScreenCover(isPresented: $presentSheet) {
                    ProfileView()
                }
                .fullScreenCover(isPresented: $showingHelpSheet) {
                    LaunchScreenHelpView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Help") {
                            showingHelpSheet.toggle()
                        }
                        .tint(.accentColor)
                        .font(.lovelo())
                    }
                }
            }
        }
        
    }
    
    func enableButtons() {
        let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let emailIsGood = emailPredicate.evaluate(with: email)
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let passwordIsGood = passwordPredicate.evaluate(with: password)
        
        buttonDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if let error = error {
                print("😡 SIGN-UP ERROR: \(error.localizedDescription)")
                alertMessage = "SIGN-UP ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration success!")
                presentSheet = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if let error = error {
                print("😡 LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Login successful!")
                presentSheet = true
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ProfileViewModel())
    }
}
