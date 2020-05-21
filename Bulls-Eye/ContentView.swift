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
    
    var body: some View {
        VStack {
            Spacer()
            //Target View
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
            }
            Spacer()
            
            //Slider View
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            
            //Hit Me View
            Button(action: {
                self.isTapButton = true
                
            }) {
                Text("Hit Me")
            }
            .alert(isPresented: $isTapButton) { () -> Alert in
                return Alert(title: Text(self.alertTitle()), message: Text("The value you get is \(sliderValueRounded())\n" +
                    "You scored \(getPointforRound()) in this round"
                ), dismissButton: .default(Text("Keluar")) {
                    self.score += self.getPointforRound()
                    self.target = Int.random(in: 1...100)
                    self.roundNumber += 1
                    })
            }
            Spacer()
            
            //Score View
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score: ")
                Text("\(score)")
                Spacer()
                Text("Round: ")
                Text("\(roundNumber)")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            } .padding(.bottom, 30)
        }
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
