//
//  ContentView.swift
//  Bulls-Eye
//
//  Created by Randy Efan Jayaputra on 19/05/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isTapButton = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var roundNumber = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 19))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonTextLargeStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonTextSmallStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            //Target View
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            
            //Slider View
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            
            //Hit Me View
            Button(action: {
                self.isTapButton = true
                
            }) {
                Text("Hit Me").modifier(ButtonTextLargeStyle())
            }
            .alert(isPresented: $isTapButton) { () -> Alert in
                return Alert(title: Text(self.alertTitle()), message: Text("The value you get is \(sliderValueRounded())\n" +
                    "You scored \(getPointforRound()) in this round"
                ), dismissButton: .default(Text("Go Again!")) {
                    self.score += self.getPointforRound()
                    self.target = Int.random(in: 1...100)
                    self.roundNumber += 1
                    })
            } .background(Image("Button"))
            Spacer()
            
            //Score View
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                HStack {
                    Image("StartOverIcon").accentColor(midnightBlue)
                    Text("Start Over").modifier(ButtonTextSmallStyle())
                    }
                }.background(Image("Button"))
                Spacer()
                Text("Score: ").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round: ").modifier(LabelStyle())
                Text("\(roundNumber)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: InfoView()) {
                    HStack {
                    Image("InfoIcon").accentColor(midnightBlue)
                    Text("Info").modifier(ButtonTextSmallStyle())
                    }
                } .background(Image("Button"))
            } .padding(.bottom, 30)
        }
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("BullsEye")
    }
    
    func sliderValueRounded() -> Int {
         Int(sliderValue.rounded())
    }
    
    func amountOff () -> Int {
        abs(target-sliderValueRounded())
    }
    
    func getPointforRound() -> Int {
        let difference = amountOff()
        let point : Int
        if difference == 0 {
            point = 200 - difference
        } else if difference == 1 {
            point = 150 - difference
        } else {
            point = 100 - amountOff()
        }
        return point
    }
    
    func resetGame() {
        self.score = 0
        self.roundNumber = 1
        self.target = Int.random(in: 1...100)
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        
        if difference == 0 {
             title = "Perfect"
        } else if difference <= 5 {
            title = "You Almost Had!"
        } else if difference <= 10 {
            title = "Not Bad!"
        } else {
            title = "are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
