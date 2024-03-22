//
//  ContentView.swift
//  Dora
//
//  Created by Aravind on 20/01/24.
//

import SwiftUI
import SwiftData


enum KeyboardType {
    case normal
    case phone
}
struct BlackLine : View {
//    let globalColor = GlobalColors();
    let marginEnd : CGFloat;
    let height : CGFloat;
    let isStart : Bool;
    init(marginEnd: CGFloat, height : CGFloat, isStart : Bool? = true) {
        self.marginEnd = marginEnd
        self.height = height
        self.isStart = isStart ?? true
    }
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: self.height)
            .background(Color("black"))
            .padding(.top,10)
            .padding(self.isStart ? .trailing : .leading, self.marginEnd)
    }
}

struct TitleText : View {
//    @EnvironmentObject var globalColors : GlobalColors;
    let fontSize : CGFloat;
    let displayText : String;
    init(fontSize: CGFloat, displayText: String) {
        self.fontSize = fontSize
        self.displayText = displayText
    }
    var body: some View {
        HStack {
            Text(displayText).font(.custom("PlayfairDisplay-Regular", size: fontSize))
                .foregroundColor(Color("black"))
            Spacer()
        }
    }
}

struct ShowPassword : View {
    let placeHolder : String;
    @Binding var showPassword : Bool;
    var body: some View {
        if self.placeHolder.contains("Password"){
            HStack{
                Spacer()
                Button(action: {
                    print("button clicked",showPassword)
                    showPassword.toggle()
                }){
                    Image(showPassword ? "eye" : "eye-slash").renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color("black"))
                        .frame(width: 24,height: 24)
                }.padding(.trailing,10)
            }
        }
    }
}

struct InputField : View {
//    @EnvironmentObject var globalColor : GlobalColors
    @Binding var data : String;
    @State private var showPassword : Bool = false;
    let placeHolder : String;
    let leftIcon : String;
    var keyboardType: KeyboardType = .normal
    var body: some View {
        ZStack(alignment : .leading){
//            if data.isEmpty{
                HStack{
//                    if data.isEmpty{
                        if self.leftIcon != ""{
                            Image(self.leftIcon).renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/).resizable().frame(width: 20,height: 20)
                                .foregroundColor(Color("black"))
                        }
                    if data.isEmpty{
                        Text(self.placeHolder)
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                    }
                    Spacer()
                   
                }.padding(.horizontal,20)
//            }

            if !showPassword && self.placeHolder.contains("Password") {
                SecureField("", text: $data)
                    .frame(width: .infinity)
                    .lineLimit(1)
                    .padding(10)
                    .padding(.leading, self.leftIcon == "" ? 0 : 20)
                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                    .foregroundColor(Color("black"))
                    .padding(.horizontal,self.leftIcon == "" ? 10 : 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("black"), lineWidth:2)
                    )
                ShowPassword(placeHolder: self.placeHolder, showPassword: $showPassword)
                
            }else{
                TextField("", text: $data)
                    .frame(width: .infinity)
                    .lineLimit(1)
                    .padding(10)
                    .keyboardType(keyboardType == .phone ? .numberPad : .default)
                    .padding(.leading,self.leftIcon == "" ? 0 : 20)
                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                    .foregroundColor(Color("black"))
                    .padding(.horizontal,self.leftIcon == "" ? 10 : 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("black"), lineWidth:2)
                    )
                ShowPassword(placeHolder: self.placeHolder, showPassword: $showPassword)
            }
        }.padding(.top,20)
    }
}

struct RememberMe : View {
    @Binding var isOn : Bool;
    @State var text : String ;
    @State var showForgotPassword : Bool;
    var body: some View {
        HStack{
            Button(action:{
                isOn.toggle()
            }){
                Image(isOn ? "check-box" : "Rectangle")
                    .resizable()
                    .frame(width: 25,height: 25)
            }
            Text(text)
                .font(.custom("PlayfairDisplay-Regular", size: 17))
            Spacer()
            if showForgotPassword{
                Text("Forgot password")
                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                    .opacity(0.5)
            }
        }.padding(.top,15)
    }
}


struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var userName : String = "";
    @State private var passWord : String = "";
    @State private var rememberMe : Bool = false;
    @State private var showAlert : Bool = false;
    @State private var errorMsg : String = "";
    @State private var isLoggedIn : Bool = false;
    
//    @EnvironmentObject var globalColors : GlobalColors;
    let iconNames = ["facebook", "twitter", "linkedin", "google"];
    var body: some View {
        NavigationView{
            ZStack{
                Color("statusbar").edgesIgnoringSafeArea(.all)
//                Color.pink
//                    .edgesIgnoringSafeArea(.all)
                ZStack{
                    Color("background")
                        .ignoresSafeArea(.keyboard, edges: .bottom)
//                    colorScheme == .light ? Color.white : Color(hex: 0x04a525e)
                    ScrollView(.vertical,showsIndicators: false){
                        VStack(){
                            BlackLine(marginEnd: 300,height: 2)
                            BlackLine(marginEnd: 100,height: 5)
                            TitleText(fontSize: 30, displayText: "Welcome back!").padding(.top,30)
                            TitleText(fontSize: 17, displayText: "Please, sign in to continue.")
                            InputField(data: $userName,placeHolder: "User name", leftIcon: "user")
                            InputField(data: $passWord, placeHolder: "Password", leftIcon: "lock")
                            RememberMe(isOn: $rememberMe, text: "Remember me", showForgotPassword: true)
                                .alert(isPresented: $showAlert, content: {
                                    Alert(title: Text("Error").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/), message: Text(errorMsg))
                                })
                            Button(action:{
                                let api = ApiService();
                                api.login(email: userName, password: passWord) { user in
                                    isLoggedIn = true
                                } onFailure: {error in
                                    errorMsg = error;
                                    showAlert = true
                                }
                            }){
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .padding(15)
                                    .padding(.horizontal,100)
                                    .background(Color("button"))
                                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                                    .cornerRadius(50)
                            }.padding(.top,30)
                            
                            Text("Or sign in with")
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                                .padding(.vertical)
                                .foregroundColor(Color("black"))
                            HStack{
                                ForEach(iconNames, id:\.self){
                                    iconeName in
                                    Button(action: {}){
                                        Image(iconeName)
                                            .resizable()
                                            .frame(width: 32,height: 32)
                                            .padding(.horizontal,8)
                                    }
                                }
                            }
                            HStack{
                                Text("Don’t have an account?")
                                    .foregroundColor(Color("black"))
                                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                                NavigationLink{
                                    SignUp()
                                        .navigationBarBackButtonHidden(true)
                                }label: {                                    Text("Sign up")
                                        .foregroundColor(Color("black"))
                                        .font(.custom("PlayfairDisplay-Regular", size: 17))
                                        .opacity(0.5)
                                }
                                
                            }.padding(.vertical,20)
                            BlackLine(marginEnd: 100,height: 5,isStart: false)
                            BlackLine(marginEnd: 300,height: 2,isStart: false)
                            Spacer()
                            NavigationLink(destination: Home().navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
                                EmptyView()
                            }
                            .hidden()
                            
                        }.padding(.horizontal,30)
                            .frame(width: UIScreen.main.bounds.width, height: .infinity)
                    }.clipped()
                }
            }.ignoresSafeArea(.keyboard,edges: .all)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
            )
        }
//        .onChange(of: colorScheme, {
//            globalColors.updateColors(for: colorScheme)
//        }).onAppear(){
//            globalColors.updateColors(for: colorScheme)
//        }
    }
    
//    init(){
//        globalColors.updateColors(for: colorScheme)
//    }
   /* init() {
        for fontFamily in UIFont.familyNames{
            print(fontFamily)
            for fontName in UIFont.fontNames(forFamilyName: fontFamily){
                print("---\(fontName)")
            }
        }
    } */
}

  

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

