//
//  ContentView.swift
//  Tip Calculator
//
//  Created by Chhorn Vatana on 7/21/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI

struct FirstScreen: View {
    
    // MARK: - PROPERTIES
    
    @State private var textfieldValue: String = ""
    @State private var split = 2
    @State private var tipSelected : Int = 10
    @State private var result: Double = 0.00
    @State private var buttonOneTriggered: Float = 0.5
    @State private var buttonTwoTriggered: Float = 1
    @State private var buttonThreeTriggered: Float = 0.5
    @State private var isPresentingModalView = false
    var height = UIScreen.main.bounds.height
    
    // MARK: - BODY
    
    var body: some View {
         
        ZStack(alignment: .top) {
            
            Color(red: 0.24, green: 0.30, blue: 0.35)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                VStack (alignment: .center, spacing: 6) {
                    
                    HStack  {
                        
                        VStack (alignment: .leading) {
                            Text("Tipsy")
                                .bold()
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                            Text("Enter bill total")
                                .foregroundColor(.white)
                                .opacity(65)
                                .font(.system(size: 26))
                        }  //: VStack
                        Spacer()
                        Image("inAppLogo")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90, alignment: .center)
                    }  //:  HStack
                    .padding(.horizontal)
                    .padding(.top)
                    
                    TextField("Input the amount of money $/៛", text: $textfieldValue)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(height: 70)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.20))
                                .padding(.horizontal)
                        )
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                        .keyboardType(.decimalPad)
                    
                    HStack {
                        Text("Select tip")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .opacity(90)
                        Spacer()
                    }  //: HStack
                    .padding(.horizontal)
                    
                    HStack {
                        
                        Button(action: {
                            self.tipSelected = 0
                            self.buttonOneTriggered = 1
                            self.buttonTwoTriggered = 0.5
                            self.buttonThreeTriggered = 0.5
                            
                        }) {
                            Image("TipButtons")
                                .renderingMode(.original)
                                .overlay(Text("0%")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30)))
                        } .opacity(Double(buttonOneTriggered))
                        
                        Button(action: {
                            
                            self.tipSelected = 10
                            self.buttonOneTriggered = 0.5
                            self.buttonTwoTriggered = 1
                            self.buttonThreeTriggered = 0.5
                            
                        }) {
                            Image("TipButtons")
                                .renderingMode(.original)
                                .overlay(Text("10%")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30)))
                        } .opacity(Double(buttonTwoTriggered))
                        
                        
                        .padding(.horizontal)
                        
                        Button(action: {
                            
                            self.tipSelected = 20
                            self.buttonOneTriggered = 0.5
                            self.buttonTwoTriggered = 0.5
                            self.buttonThreeTriggered = 1
                            
                        }) {
                            Image("TipButtons")
                                .renderingMode(.original)
                                .overlay(Text("20%")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30)))
                        }   .opacity(Double(buttonThreeTriggered))
                        
                    }  //:  HStack
                    
                    HStack {
                        
                        Text("Choose Split")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                        Spacer()
                          
                    } // HStack
                    .padding(.horizontal)

                    Stepper("\(split)", value: $split, in: 2...20)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .padding(.bottom)
                        .padding(.horizontal, 40)
                    
                }  //: VStack
                
                .background(
                    Rectangle()
                        .fill(Color(red: 0.44, green: 0.68, blue: 0.64))
                        .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                        .edgesIgnoringSafeArea(.top)
                )
                
                Spacer()
                
                Button(action: {
                    
                    
                    let splitAmount: Double = (Double(textfieldValue) ?? 0.00 ) / Double(split)
                    
                    let tipAmount : Double = splitAmount * (Double(Double(tipSelected) / 100.00))
                    
                    result = splitAmount + tipAmount
                    
                    self.isPresentingModalView.toggle()
                })
                {
                    Rectangle()
                        .fill(Color(red: 0.38, green: 0.65, blue: 0.60))
                        .frame(width: 300, height: 75, alignment: .center)
                        .clipShape(Capsule())
                        .overlay(
                            Text("Calculate")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        )
                    
                }
                .padding(.bottom)
                .padding(.horizontal)
                .sheet(isPresented: $isPresentingModalView, content: {
                    /// present the second screen
                    SecondScreen(result: $result, split: $split, tipSelected: $tipSelected)
                })
            }

        }
    }
}

// MARK: - EXTENSIONS

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

// MARK: - SECOND SCREEN

struct SecondScreen: View {
    
    // MARK: - PROPERTIES
    
    @Binding var result: Double
    @Binding var split: Int
    @Binding var tipSelected: Int
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack () {
            Color(red: 0.24, green: 0.30, blue: 0.35)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center, spacing: 12) {
                Text("Total per person")
                    .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                    .font(.system(size: 35))
                    .padding(.top)
                
                Text(String(format: "%.2f", result))
                    .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                    .font(.system(size: 60))
                    .lineLimit(1)
                
                VStack {
                    Text("Split between \(split) people, with \(tipSelected)% tip.")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.center)
                        .opacity(95)
                        .padding(.horizontal)
                    
                    Spacer()
                }  //:  VStack
                .padding(.top, 30)
                .background(
                    Rectangle()
                        .fill(Color(red: 0.44, green: 0.68, blue: 0.64))
                        .frame(width: UIScreen.main.bounds.width)
                        .cornerRadius(30, corners: [.topRight, .topLeft])
                )
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
            }  //:  VStack
        }  //: VStack
        
    }


    
    // MARK: - PREVIEW
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            FirstScreen()
        }
    }
}
