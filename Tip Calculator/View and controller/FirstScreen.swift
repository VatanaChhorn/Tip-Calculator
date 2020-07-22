//
//  ContentView.swift
//  Tip Calculator
//
//  Created by Chhorn Vatana on 7/21/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI

struct FirstScreen: View {
    
    @State private var textfieldValue: String = ""
    @State private var split = 2
    @State private var tipSelected = 10
    @State private var buttonOneTriggered: Float = 0.5
    @State private var buttonTwoTriggered: Float = 1
    @State private var buttonThreeTriggered: Float = 0.5
    @State private var isPresentingModalView = false
    @State private var result: Double = 0.0
    
    var body: some View {
        
        //     NavigationView{
        
        
        ZStack(alignment: .top) {
            
            
            Color(red: 0.24, green: 0.30, blue: 0.35)
                .edgesIgnoringSafeArea(.all)
            Image("UpperView")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.top)
            
            VStack  {
                HStack  {
                    VStack {
                        Text("Tipsy")
                            .bold()
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                        Text("Enter bill total")
                            .foregroundColor(.white)
                            .opacity(65)
                            .font(.system(size: 26))
                            .offset(x: 20)
                    } .offset(x: 10)
                    Spacer()
                    Image("inAppLogo")
                        .aspectRatio(contentMode: .fit)
                } .offset(y: -15)
                TextField("Input the amount of money $/៛", text: $textfieldValue)
                    .multilineTextAlignment(.center)
                    .frame(width: 400, height: 70)
                    .background(Image("TextFieldBackground")
                        .resizable()
                        .aspectRatio( contentMode: .fill))
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                    .offset( y: -40)
                    .keyboardType(.numberPad)
                    .padding(.top)
                HStack {
                    Text("Select tip")
                        .offset(x: 30, y: -20)
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                       .opacity(90)
                    Spacer()
                }
                
                HStack {
                    Button(action: {
                        self.tipSelected = 0
                        print(self.tipSelected)
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
                        print(self.tipSelected)
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
                        
                        
                        .padding()
                    Button(action: {
                        
                        self.tipSelected = 20
                        print(self.tipSelected)
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
                    
                } .offset( y: -35)
                
                
                HStack {
                    Text("Choose Split")
                        .offset(x: 30, y: -45)
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                     
                    Spacer()
                } // End of HStack
                Stepper("\(split)", value: $split, in: 2...20)
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding(.horizontal, 35)
                    .offset( y: -50)
                
                Spacer()
                
                
                
                
                
                Button(action: {
                    //Do the calculation
                    let splitAmount = (Double(self.textfieldValue) ?? (0.0)) / Double(Int(self.split))
                    let tipAmount = (Double(self.textfieldValue) ?? 0.0 ) * Double(Double(self.tipSelected)/100.0)
                    
                    self.result = splitAmount + tipAmount
                    
                    print(self.textfieldValue)
                    print(self.split)
                    print(splitAmount)
                    print(tipAmount)
                    
                    
                    self.isPresentingModalView.toggle()
                })
                {
                    Rectangle()
                        .fill(Color(red: 0.38, green: 0.65, blue: 0.60))
                        .frame(width: 350, height: 75, alignment: .center)
                        .clipShape(Capsule())
                        .overlay(
                            Text("Calculate")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                             
                            
                    )
                    
                }    .padding(.bottom)
                    .padding(.horizontal)
                .sheet(isPresented: $isPresentingModalView, content: {
                    SecondScreen(split: self.$split, tipSelected: self.$tipSelected, result: self.$result)
                     
                })
                
            }
            
            //   }
            
            
        }
    }
}

struct SecondScreen: View {
    
    @Binding var split: Int
    @Binding var tipSelected: Int
    @Binding var result: Double
    var body: some View {
        
        ZStack ( alignment: .top){
            Color(red: 0.24, green: 0.30, blue: 0.35)
                .edgesIgnoringSafeArea(.all)
            
            ZStack ( alignment: .bottom) { Image("BottomView")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .offset(y:225)
            }
            
            VStack  {
                Text("Total per person")
                    .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                    .font(.system(size: 35))
                    .offset(y: 40)
                Text(String(format: "%.2f", result))
                    .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                    .font(.system(size: 60))
                    .offset(y: 50)
                    .lineLimit(1)
                
                Text("Split between \(split) people, with \(tipSelected)% tip.")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30))
                    .offset(y: 130)
                    .multilineTextAlignment(.center)
                    .opacity(95)
                    .padding(.horizontal)
                
                
                
            }
            
            
        }
        
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            FirstScreen()
        }
    }
}
