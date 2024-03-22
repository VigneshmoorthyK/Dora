//
//  SignUp.swift
//  Dora
//
//  Created by Aravind on 02/03/24.
//

import SwiftUI

struct SignUp : View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var signupModel = SignUpViewController();
    @State private var userName : String = "";
    @State private var email : String = "";
    @State private var password : String = "";
    @State private var confirmPassword : String = "";
    @State private var phoneNumber : String = "";
    @State private var acceptTerms : Bool = false;
    @State private var showAlert : Bool = false;
    @State private var isSignedUp : Bool = false;
    var body: some View {
        ZStack{
            Color("statusbar").edgesIgnoringSafeArea(.all)
            ZStack{
                Color("background")
                    .ignoresSafeArea(.keyboard,edges: .bottom)
                VStack{
                    HStack(){
                        Spacer()
                        Image("sideline").resizable()
                            .frame(width: 200,height: 230)
                    }
                    Spacer()
                }
                VStack{
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("arrow-left").resizable().frame(width: 34,height: 34)
                        })
                        Spacer()
                    }.padding(.top,30)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text(signupModel.errorMessage), dismissButton: .default(Text("OK")))
                        }
                    TitleText(fontSize: 30, displayText: "Create Account!")
                    TitleText(fontSize: 17, displayText: "Please, sign up to continue.")
                    InputField(data: $userName, placeHolder: "Full Name", leftIcon: "")
                    InputField(data: $email, placeHolder: "Email", leftIcon: "")
                    InputField(data: $phoneNumber, placeHolder: "Phone Number", leftIcon: "",keyboardType: KeyboardType.phone)
                    InputField(data: $password, placeHolder: "Password", leftIcon: "")
                    InputField(data: $confirmPassword, placeHolder: "Confirm Password", leftIcon: "")
                    RememberMe(isOn: $acceptTerms, text: "I Agree with privacy and policy", showForgotPassword: false)
                    Button{
                        signupModel.handleSignUp(email: email, userName: userName, phoneNumber: phoneNumber, password: password,confirmPassword: confirmPassword, termsAndPolicy: acceptTerms){ res in
                            signupModel.showLoader = false;
                            if !res.access_token.isEmpty {
                                isSignedUp = true
                            }
                        } onFailure: {error in
                            signupModel.showLoader = false;
                            showAlert = true
                        }
                        
                    }label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding(12)
                            .padding(.horizontal,100)
                            .font(.custom("PlayfairDisplay-Regular", size: 22))
                            .background(Color("button"))
                            .cornerRadius(50)
                    }
                    HStack{
                        Text("Already have an account?")
                            .foregroundColor(Color("black"))
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Sign In")
                                .foregroundColor(Color("black"))
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                                .opacity(0.5)
                        }
                        
                        Spacer()
                    }.padding(.top,10)
                    Spacer()
                }.padding(.horizontal,30)
                    .padding(.top,30)
                Spacer()
                NavigationLink(destination: Home(), isActive: $isSignedUp){
                    EmptyView()
                }
                .hidden()
                HStack{
                    Image("sideline")
                        .resizable()
                        .rotationEffect(.degrees(180),anchor: .bottom)
                        .frame(width: 200,height: 230)
                    Spacer()
                }.padding(.top,130)
                if signupModel.showLoader {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                    .tint(.blue)}
            }
        }
    }
}

#Preview {
    SignUp()
}
