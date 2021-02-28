//
//  ChooseFeatureView.swift
//  YucaBen
//
//  Created by Cihat Bostancı on 20.02.2021.
//

import SwiftUI



class SummaryModel : ObservableObject {
    
    @Published var pieceTotal : String = "" {
        willSet(newValue) {
            print(newValue)
        }
    }
    
    @Published var forPlakaTotalPricing : String = "" {
        willSet(newValue) {
            print(newValue)
        }
    }
    
    @Published var amountForProfitText : String = "" {
        willSet(newValue) {
            print(newValue)
        }
    }
    
    @Published var newForProfitPlakaTextPricing : String = "" {
        willSet(newValue) {
            print(newValue)
        }
    }
    
    init(pieceTotal: String,forPlakaTotal: String,amountForProfitText:String,newForProfitPlakaTextPricing:String  ) {
        self.pieceTotal = pieceTotal
        self.forPlakaTotalPricing = forPlakaTotal
        self.amountForProfitText = amountForProfitText
        self.newForProfitPlakaTextPricing = newForProfitPlakaTextPricing
    }
   
}

struct SummaryView : View {
    
    @Binding var perPieceText : String
    @Binding var perPlakaText : String
    @Binding var amountForProfitText : String
    @Binding var newForProfitPlakaTextPricing : String
   
    var body: some View {
        return
            VStack(alignment: .leading, spacing: 10, content:{
            HStack{
                Text("Toplam Birim Fiyatı:"  )
                    .font(.system(size: 20))
                    .bold()
                    .font(.title)
                    .accentColor(.black)
                Text(perPieceText)
                Text(" TL")
                
            }
            HStack{
                Text("Maliyet Birim Fiyatı:"  )
                    .font(.system(size: 20))
                    .bold()
                    .font(.title)
                    .accentColor(.black)
                Text(perPlakaText)
                Text(" TL")
                
            }
            HStack{
                    Text("Kar'a Göre Birim Fiyatı:"  )
                        .font(.system(size: 20))
                        .bold()
                        .font(.title)
                        .accentColor(.black)
                    Text(newForProfitPlakaTextPricing)
                    Text(" TL")
                    
                }
            HStack{
                Text("Kar'a Göre Tutar Fiyatı:"  )
                        .font(.system(size: 20))
                        .bold()
                        .font(.title)
                        .accentColor(.black)
                Text(amountForProfitText)
                Text(" TL")
                    
                }
                
           
        })
        
    }
}

struct ChooseFeatureView: View {
    
    @Binding var navigationBarHidden: Bool
    @EnvironmentObject var viewModel: DetailViewModel
    @ObservedObject var summaryModel = SummaryModel(pieceTotal: "0",forPlakaTotal: "0", amountForProfitText: "0", newForProfitPlakaTextPricing: "0")
   
    
    var body: some View {
    
            
            ScrollView {
                HStack(alignment: .center){
                    
                    
                    VStack(alignment: .leading) {
                        
                        Group {
                            Text("Kutu Bilgileri")
                                .bold()
                                .font(.title)
                                .accentColor(.black)
                            Spacer()
                            Text("Plaka Gramaj(gram):  " + String(viewModel.weight))
                                .font(.system(size: 15))
                                .font(.callout)
                                .accentColor(.black)
                            Text("Plaka Boy(cm):  " + String(viewModel.height))
                                .font(.system(size: 15))
                                .font(.callout)
                                .accentColor(.black)
                            Text("Plaka En (cm):  " + String(viewModel.width))
                                .font(.system(size: 15))
                                .accentColor(.black)
                            Text("Kutu Adedi(tane):  " + String(viewModel.piece))
                                .font(.system(size: 15))
                                .font(.callout)
                                .accentColor(.black)
                            Text("Ürün/Tabaka:  " + String(viewModel.productSheet))
                                .font(.system(size: 15))
                                .font(.callout)
                                .accentColor(.black)
                            Text("Baskı:  " + String(viewModel.printAmount))
                                .font(.system(size: 15))
                                .font(.callout)
                                .accentColor(.black)
                            Text("Kar Oranı:  " + String(viewModel.profitDegree))
                                .font(.system(size: 15))
                                .font(.callout)
                                .accentColor(.black)
                            
                           
                        }
                        Group {
                            Spacer()
                            Divider()
                            Spacer()
                            Text("İşlemler"  )
                                .font(.system(size: 20))
                                .bold()
                                .font(.title)
                                .accentColor(.black)
                            
                            
                            Spacer()
                        }
                        
                        Group {
                            CheckboxFieldView(checkState:false,title:"Kroma",perAmount: "8", functionalityType: Functionality.allPurposeFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Ondüle",perAmount: "1,31", functionalityType: Functionality.meterFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Kraft", perAmount: "3,63", functionalityType: Functionality.meterFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Sıvama",perAmount: "0,30",  functionalityType: Functionality.meterFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Kesim",perAmount: "0,10", functionalityType: Functionality.nonFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Baskı",perAmount: findPrintAmount(piece: viewModel.piece, printAmount: viewModel.printAmount,productSheet: viewModel.productSheet),functionalityType:Functionality.printingFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                    
                            CheckboxFieldView(checkState:false,title:"Yan Yapıştırma",perAmount: "0,10", functionalityType: Functionality.sideAndDeepFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Dip Yapıştırma",perAmount: "0,20",functionalityType: Functionality.sideAndDeepFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"UV Lak",perAmount: "0,40",functionalityType: Functionality.meterFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                            CheckboxFieldView(checkState:false,title:"Parlak Selefon",perAmount: "0,65",functionalityType: Functionality.meterFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                        }
                        Group{
                            CheckboxFieldView(checkState:false,title:"Mat Selefon",perAmount: "0,75",functionalityType: Functionality.meterFunctionality).environmentObject(summaryModel).environmentObject(viewModel)
                        }
                        
                       
                        Divider()
                        Spacer()
                        Spacer()
                        
                        //Passing the Binding to name
                        SummaryView(perPieceText: self.$summaryModel.pieceTotal,
                                    perPlakaText: self.$summaryModel.forPlakaTotalPricing,
                                    amountForProfitText: self.$summaryModel.amountForProfitText,
                                    newForProfitPlakaTextPricing:self.$summaryModel.newForProfitPlakaTextPricing
                                    )
                       
                        
                    }.onAppear {
                        self.navigationBarHidden = true
                    }
                }.padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    
    func findPrintAmount(piece: String ,printAmount: String, productSheet: String) -> String {
        let pieceF = piece.toFloat() ?? 0.0
        let printAmountF = printAmount.toFloat() ?? 0.0
        let productSheetF = productSheet.toFloat() ?? 0.0

        let perPlaka :Float = pieceF / productSheetF
        
        var returnPerAmount: String = ""
        
        if perPlaka >= 3000 {
            let tempPerPrintAmountF :Float = printAmountF/3000
            
            returnPerAmount = String(format: "%.2f", tempPerPrintAmountF )
        } else {
            let tempPerPrintAmountF :Float = printAmountF/perPlaka
            returnPerAmount = String(format: "%.2f", tempPerPrintAmountF )
        }

        return returnPerAmount.replacingOccurrences(of: ".", with: ",")
      
    }
}




extension View {
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}


