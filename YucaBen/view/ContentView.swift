//
//  ContentView.swift
//  YucaBen
//
//  Created by Cihat Bostancı on 20.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var navigationBarHidden = false
    @ObservedObject var viewModel = DetailViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView{
            VStack(alignment: .leading){
                Spacer()
                HStack(alignment: .center) {
                    Text("Kutu Bilgileri")
                        .font(.system(size: 25))
                        .bold()
                        .font(.title)
                        .accentColor(.black)
                    
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Plaka Gramaj:")
                        .font(.callout)
                        .bold()
                    TextField("Gram",text: self.$viewModel.weight, onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad).font(.callout)
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Plaka Boy:")
                        .font(.callout)
                        .bold()
                    TextField("Cm",text: self.$viewModel.height, onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad).font(.callout)
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Plaka En:")
                        .font(.callout)
                        .bold()
                    TextField("Cm", text: self.$viewModel.width, onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad).font(.callout)
                    
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Kutu Adedi:")
                        .font(.callout)
                        .bold()
                    TextField("Adet", text: self.$viewModel.piece, onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad).font(.callout)
                    
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Ürün/Tabaka:")
                        .font(.callout)
                        .bold()
                    TextField( "Adet" ,text: self.$viewModel.productSheet, onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad).font(.callout)
                    
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Baskı:")
                        .font(.callout)
                        .bold()
                    TextField( "Fiyat(tl)" ,text: self.$viewModel.printAmount, onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad).font(.callout)
                    
                }.padding()
      
                Spacer()
                NavigationLink(destination: ChooseFeatureView(navigationBarHidden:$navigationBarHidden).environmentObject(viewModel)) {
                    Text("Bilgileri Onayla")
                        .frame(minWidth: 0, maxWidth: 300, alignment: .center)
                        .padding()
                        .foregroundColor(.black)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        
                }
            }.navigationBarTitle("Ambalaj Maliyet")
            .font(.system(size: 25))
            .frame(alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 0))
        }
            
        }.onTapGesture {
            self.endEditing()
        }
        
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

class DetailViewModel: ObservableObject {
    
    @Published  var weight: String = ""
    @Published  var height: String = ""
    @Published  var width:  String = ""
    @Published  var piece:  String = ""
    @Published  var productSheet:  String = ""
    @Published  var printAmount:  String = ""
    @Published  var profitDegree:  String = ""

    
}

func keyboardDissmis(text:String)->Text{
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    
    return Text(text)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
