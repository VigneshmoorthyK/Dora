//
//  SignUp.swift
//  Dora
//
//  Created by Aravind on 02/03/24.
//

import SwiftUI

struct SquareDesign : View {
    let outerSize : CGFloat = 45;
    let innerSize : CGFloat = 35;
    let borderWidth : CGFloat = 1;
    let leftToRight : Bool;
    var body: some View{
        HStack{
            if leftToRight {
                Spacer()
            }
            Rectangle()
                .frame(width: outerSize, height: outerSize)
                .foregroundColor(Color("background"))
                .border(Color("black"),width: borderWidth)
                .overlay(
                    Rectangle()
                        .frame(width: innerSize, height: innerSize)
                        .foregroundColor(Color("background"))
                        .border(Color("black"),width: borderWidth)
                        .alignmentGuide(HorizontalAlignment.center, computeValue: { d in
                            d[leftToRight ? .trailing : .leading]
                        })
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in
                            d[leftToRight ? .leading : .trailing]
                        }).shadow(radius: 1,x: leftToRight ? -5 : 5,y: leftToRight ? 5 : -2)
                ).shadow(radius: 1,x: leftToRight ? -5 : 5,y: leftToRight ? 5 : -2)
            if !leftToRight {
                Spacer()
            }
        }
    }
}

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
                   SquareDesign(leftToRight: true)
                    Spacer()
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("arrow-left").resizable().frame(width: 34,height: 34)
                        })
                        Spacer()
                    }.padding(.horizontal,30)
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            TitleText(fontSize: 30, displayText: "Create Account!")
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Error"), message: Text(signupModel.errorMessage), dismissButton: .default(Text("OK")))
                                }
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
                    }
                    .KeyboardResponsive()
                    Spacer()
                    NavigationLink(destination: Home(), isActive: $isSignedUp){
                        EmptyView()
                    }
                    .hidden()
                    SquareDesign(leftToRight:false)
                }
                    .ignoresSafeArea(.keyboard,edges: .bottom)
                if signupModel.showLoader {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                    .tint(.blue)}
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

#Preview {
    SignUp()
}
