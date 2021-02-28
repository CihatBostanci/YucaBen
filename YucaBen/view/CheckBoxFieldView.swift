//
//  CheckBoxFieldView.swift
//  YucaBen
//
//  Created by Cihat Bostancı on 27.02.2021.
//

import SwiftUI

struct CheckboxFieldView : View {
    
    @State var checkState:Bool = false ;
    @State var title:String = "" ;
    @State var perAmount:String = "" ;
    @State var functionalityType = Functionality.nonFunctionality
    
   
    @EnvironmentObject var summaryModel:SummaryModel
    @EnvironmentObject var viewModel: DetailViewModel
    
    
    var body: some View {
        
        

        Button( action:
                    {
                        //1. Save state
                        self.checkState = !self.checkState
                        
                        //Take And convert Float value
                        let pieceTotalF = Float(summaryModel.pieceTotal) ?? 0.0
                        let heightF = Float(viewModel.height) ?? 0.0
                        let widthF = Float(viewModel.width) ?? 0.0
                        let weightF = Float(viewModel.weight) ?? 0.0
                        let perAmountF = self.perAmount.toFloat() ?? 0.0
                        let productSheetF = Float(viewModel.productSheet) ?? 0.0
                        let printAmountF = Float(viewModel.printAmount) ?? 0.0
                        let profitDegreeF = Float(viewModel.profitDegree) ?? 0.0
                        let pieceNumberF = Float(viewModel.piece) ?? 0.0
                        
                        //Log values
                        print(" Name :\(self.title) State : \(self.checkState)  PerAmount :\(perAmountF) PieceTotal :\(pieceTotalF) ProductSheet :\(productSheetF) printAmount :\(printAmountF) Func Type : \(self.functionalityType) piece Number : \(pieceNumberF) profit Degree : \(profitDegreeF) " )
                    
                            
                            switch(self.functionalityType) {
                                case .allPurposeFunctionality:
                                    summaryModel.pieceTotal = allFunc(pieceTotal: pieceTotalF  ,height: heightF ,width:widthF, weight: weightF,perAmount:perAmountF, sumOrMinus: self.checkState)
                                    
                                    setSummaryModel(pieceTotal:  String(summaryModel.pieceTotal), productSheetF: productSheetF, pieceNumberF: pieceNumberF, profitDegreeF: profitDegreeF)
                                
                                    
                                    print("all fun:" , summaryModel.pieceTotal)
                                case .meterFunctionality:
                                    
                                    summaryModel.pieceTotal = meterFunc(pieceTotal: pieceTotalF , height: heightF, width:widthF, perAmount:perAmountF, sumOrMinus: self.checkState)
                                    setSummaryModel(pieceTotal:  summaryModel.pieceTotal, productSheetF: productSheetF, pieceNumberF: pieceNumberF, profitDegreeF: profitDegreeF)
                                
                                    print("meter fun:",summaryModel.pieceTotal)
                                case .nonFunctionality:
                                    summaryModel.pieceTotal = nonFunc(pieceTotal: pieceTotalF, perAmount:perAmountF,sumOrMinus: self.checkState)
                                    
                                    setSummaryModel(pieceTotal:  summaryModel.pieceTotal, productSheetF: productSheetF, pieceNumberF: pieceNumberF, profitDegreeF: profitDegreeF)
                                
                                    print("non fun:", summaryModel.pieceTotal)
                                case .printingFunctionality:
                                    summaryModel.pieceTotal = nonFunc(pieceTotal: pieceTotalF, perAmount: perAmountF,sumOrMinus:self.checkState)
                                    setSummaryModel(pieceTotal:  summaryModel.pieceTotal, productSheetF: productSheetF, pieceNumberF: pieceNumberF, profitDegreeF: profitDegreeF)
                            
                                    print("printing fun:", summaryModel.pieceTotal)
                                    
                                }
        
                    }) {
            HStack(alignment: .center, spacing: 10) {
            
                HStack (alignment: .center, spacing: 2, content: {
                    Rectangle()
                        .fill(self.checkState ? Color.green : Color.red)
                        .frame(width:20, height:20, alignment: .center)
                        .cornerRadius(5)
                })
               
                HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
    
                    Text(self.title)
                        .font(.system(size: 20))
                        .bold()
                        .font(.title)
                    Spacer()
                    
                    TextField(self.perAmount + " TL", text: self.$perAmount , onCommit: {
                        UIApplication.shared.endEditing()
                    }).keyboardType(.decimalPad)
                    .font(.callout)
                    .frame(width:40, height:40, alignment: .center)
                    
                    Text(" TL")
                        .font(.system(size: 15))
                        
                })
                
            }
        }
        .background(Color(UIColor.systemBackground))
        
    }
    func setSummaryModel(pieceTotal : String, productSheetF:Float, pieceNumberF:Float, profitDegreeF:Float ) ->Void {
        let summaryModelF = Float( pieceTotal ) ?? 0.0
        
        let forPlakaTotalStr = String(summaryModelF / productSheetF )
        summaryModel.forPlakaTotalPricing = forPlakaTotalStr
        
        let forPlakaTotalF = Float(summaryModel.forPlakaTotalPricing) ?? 0.0
        let newForPlakaTotalF = (forPlakaTotalF * profitDegreeF/100) + forPlakaTotalF
        let amountForProfitStr = String((forPlakaTotalF * pieceNumberF) + (newForPlakaTotalF * pieceNumberF))
        summaryModel.amountForProfitText = amountForProfitStr
        
        print(" Plaka Birim Fiyatı :\(forPlakaTotalStr)  Toplam Tutar :\(amountForProfitStr) Yeni Plaka Birim Fiyatı :\(newForPlakaTotalF) ")
    }
}

 


func allFunc(pieceTotal: Float, height: Float, width: Float, weight: Float , perAmount: Float, sumOrMinus: Bool ) -> String {
    var sumOfFeature :Float = 0.0
    if sumOrMinus{
        sumOfFeature = pieceTotal + ( (height/100 * width/100) * (weight/1000) * perAmount)
    } else {
        sumOfFeature = pieceTotal - ( (height/100 * width/100) * (weight/1000) * perAmount)
    }
    
    return String(format: "%.2f", sumOfFeature)
}

func meterFunc(pieceTotal: Float, height: Float, width: Float ,perAmount: Float, sumOrMinus: Bool ) -> String {
    var sumOfFeature :Float = 0.0
    if sumOrMinus {
        sumOfFeature = pieceTotal + ( (height/100 * width/100)  * perAmount)
    } else {
        sumOfFeature = pieceTotal - ( (height/100 * width/100) * perAmount)
    }
    return String(format: "%.2f", sumOfFeature )
}

func nonFunc(pieceTotal: Float ,perAmount: Float , sumOrMinus: Bool ) -> String {
    var sumOfFeature :Float = 0.0
    if sumOrMinus {
        sumOfFeature = pieceTotal  + perAmount
    } else {
        sumOfFeature = pieceTotal  - perAmount
    }
    print("non inside:" , String(format: "%.2f", sumOfFeature ))

    return String(format: "%.2f", sumOfFeature)
}
