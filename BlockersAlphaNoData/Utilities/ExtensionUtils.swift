//
//  FunctionUtils.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/07/11.
//

import Foundation

extension Float {
   
    private static var currencyFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.init(identifier: "ko_KR") // TODO: UIConfig에서 환경 설정 받아와서 값을 할당해야함
        return formatter
    }()
    
    internal var currencyRepresentation: String {
        return Float.currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}

extension Date {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat="yyyy/MM/dd E"
        return dateFormatter.string(from: self)
    }
    
}
