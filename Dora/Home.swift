import SwiftUI


struct Home : View {
    @State var searchText : String = ""
    let data = [Product(id: 1, name: "Loose open shirt", location: "Chennai", price: "$10",image:"shirt1"),
                Product(id: 2, name: "Bomber Jacket", location: "Mumbai", price: "$80", image: "shirt2"),
                Product(id: 3, name: "Loose open shirt", location: "Mumbai", price: "$80", image: "shirt1"),
                Product(id: 4, name: "Bomber Jacket", location: "Mumbai", price: "$80",image: "shirt2"),
                Product(id: 5, name: "T-Shirt", location: "Mumbai", price: "$80", image: "shirt1")]
    var body: some View{
        ZStack{
            Color("statusbar").edgesIgnoringSafeArea(.all)
            ZStack{
                Color("background")
                    .ignoresSafeArea(.keyboard,edges: .bottom)
                ScrollView(.vertical,showsIndicators: false){
                    LazyVStack{
                        VStack(alignment: .leading, content: {
                            TitleText(fontSize: 20, displayText: "Good morning!")
                            TitleText(fontSize: 33, displayText: "Vindend Na")
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundStyle(Color.white)
                                        .shadow(color: Color.gray, radius: 5, x: 0, y: 2)
                                    HStack{
                                        Image("search")
                                            .resizable()
                                            .frame(width: 20,height: 20)
                                        TextField("Search", text: $searchText)
                                            .font(.custom("PlayfairDisplay-Regular", size: 20))
                                            .frame(width: .infinity,height: 50)
                                            .foregroundStyle(Color("4D4D4D"))
                                        
                                    }.padding(.horizontal,10)
                                }.frame(width: .infinity,height: 30)
                                Button {
                                    
                                }label:{
                                    Image("filter")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }.padding(.leading,5)
                                
                            }
                        }).padding(15)
                        HStack{
                            Spacer()
                            VStack(alignment: .leading){
                                HStack{
                                    Text("30%")
                                        .foregroundStyle(.black)
                                        .font(.custom("PlayfairDisplay-Regular", size: 30))
                                    Text("OFF")
                                        .foregroundStyle(.black)
                                        .font(.custom("PlayfairDisplay-Regular", size: 25))
                                }.padding(.vertical,10)
                                Text("Vegan leather platform Mary Jane pumps.")
                                    .foregroundStyle(.black)
                                    .font(.custom("PlayfairDisplay-Regular", size: 15))
                                HStack{
                                    Text("$85.4")
                                        .foregroundStyle(.black)
                                        .font(.custom("PlayfairDisplay-Regular", size: 20))
                                    Text("$122")
                                        .foregroundStyle(.red)
                                        .font(.custom("PlayfairDisplay-Regular", size: 20))
                                        .strikethrough(true,color: .red)
                                }.padding(.top,2).padding(.bottom,20)
                            }
                            Image("shoe")
                                .resizable()
                                .frame(width: 150,height: 150)
                                .padding(.horizontal,10)
                        }
                        .background(Color("D9D9D9"))
                        .cornerRadius(20)
                        .padding(.vertical,20)
                        HStack{
                            VStack{
                                Image("pant")
                                    .resizable()
                                    .frame(width: 60,height: 60)
                                Text("Pants")
                                    .font(.custom("PlayfairDisplay-Regular", size: 18))
                                    .foregroundStyle(Color("black"))
                            }
                            Spacer()
                            VStack{
                                Image("shirt")
                                    .resizable()
                                    .frame(width: 60,height: 60)
                                Text("Shirts")
                                    .font(.custom("PlayfairDisplay-Regular", size: 18))
                                    .foregroundStyle(Color("black"))
                            }
                            Spacer()
                            VStack{
                                Image("heels")
                                    .resizable()
                                    .frame(width: 60,height: 60)
                                Text("Heels")
                                    .font(.custom("PlayfairDisplay-Regular", size: 18))
                                    .foregroundStyle(Color("black"))
                            }
                            Spacer()
                            VStack{
                                Image("socks")
                                    .resizable()
                                    .frame(width: 60,height: 60)
                                Text("Socks")
                                    .font(.custom("PlayfairDisplay-Regular", size: 18))
                                    .foregroundStyle(Color("black"))
                            }
                        }.padding()
                        HStack{
                            Text("Popular")
                                .font(.custom("PlayfairDisplay-Regular", size: 20))
                                .foregroundStyle(Color("black"))
                                .fontWeight(.bold)
                            Spacer()
                            Text("View all")
                                .font(.custom("PlayfairDisplay-Regular", size: 20))
                                .foregroundStyle(Color("black"))
                                .fontWeight(.bold)
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                                LazyHStack{
                                    ForEach(data){
                                        item in
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 0)
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: 5,x: 0,y :0)
                                            VStack{
                                                Image(item.image)
                                                    .resizable()
                                                    .frame(width: 150,height: 200)
                                                    .background(.white)
                                                VStack(alignment: .leading, content: {
                                                    Text(item.name)
                                                        .font(.custom("PlayfairDisplay-Regular", size: 15))
                                                        .foregroundStyle(Color("black"))
                                                        .padding(.horizontal,5)
                                                    HStack{
                                                        Image("location")
                                                            .resizable()
                                                            .frame(width: 15,height: 15)
                                                        Text(item.location)
                                                            .font(.custom("PlayfairDisplay-Regular", size: 15))
                                                            .foregroundStyle(Color("black"))
                                                    }.padding(.horizontal,5)
                                                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                                                        Text(item.price)
                                                            .font(.custom("PlayfairDisplay-Regular", size: 18))
                                                            .foregroundStyle(Color("black"))
                                                        Spacer()
                                                        Button(action: {}){
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 0)
                                                                    .foregroundStyle(Color.black)
                                                                    .frame(width: 50, height: 25)
                                                                Image("plus")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 15,height: 15)
                                                                    .background(.black)
                                                            }
                                                        }
                                                    })
                                                    .padding(.leading,5)
                                                    
                                                }).background(.white)
                                            }
                                        }
                                        .padding(15)
                                    }
                                }.fixedSize()
                            }
                        }.defaultScrollAnchor(.leading)
                        Spacer()
                    }.padding(.horizontal,20).clipped()
                }
            }
        }
    }



#Preview {
    Home()
}
