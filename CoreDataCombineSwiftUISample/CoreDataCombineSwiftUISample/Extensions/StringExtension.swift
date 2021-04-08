//
//  StringExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation
import UIKit

extension String {
    
    func initials() -> String {
        let trimmedTitle =  self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let trimmedTitleArray = trimmedTitle.components(separatedBy: .whitespaces)
        if trimmedTitleArray.count == 1 {
            if trimmedTitle.lengthOfBytes(using: .utf8) > 0 {
                let firstCharacter = "\((trimmedTitle.first)!)".uppercased()
                return firstCharacter
            }
        } else if trimmedTitleArray.count >= 2 {
            var firstCharacter = ""
            var secondCharacter = ""
            for element in trimmedTitleArray {
                if element.lengthOfBytes(using: .utf8) > 0 {
                    if firstCharacter.lengthOfBytes(using: .utf8) == 0 {
                        firstCharacter = "\(element.first!)".uppercased()
                    } else if secondCharacter.lengthOfBytes(using: .utf8) == 0 {
                        secondCharacter = "\(element.first!)".uppercased()
                    }
                }
            }
            return "\(firstCharacter)\(secondCharacter)"
        }
        return ""
    }
    
    func firstCharacter() -> String {
        var firstCharacter = self.first ?? "#"
        
        if (!(firstCharacter >= "a" && firstCharacter <= "z") && !(firstCharacter >= "A" && firstCharacter <= "Z") ) {
            firstCharacter = "#"
        }
        return String(firstCharacter).capitalized
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func hasNoCharacters() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func attributedString(withForegroundColor foregroundColor:UIColor,
                          withFontSize fontSize:CGFloat,
                          withParagraphSyleAlignment paragraphAlignment:NSTextAlignment = .natural) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: foregroundColor,
                                                         .font: UIFont.systemFont(ofSize: fontSize)]
        let value = NSMutableAttributedString(string: self, attributes:attributes)
        
        return value.trimmedAttributedString(set: CharacterSet.whitespacesAndNewlines)
    }
    
    func attributedString(withFont font: UIFont,
                          fontColor: UIColor,
                          alignment: NSTextAlignment = .natural) -> NSMutableAttributedString? {
        guard self.hasNoCharacters() == false else {
            return nil
        }
        
        let modifiedFont = String(format:"%@<style>body{font-family: '%@'; font-size:%fpx;}</style>", self, font.fontName, font.pointSize)
        let data = Data(modifiedFont.utf8)
        do {
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : fontColor,
                                            NSAttributedString.Key.paragraphStyle : paragraphStyle],
                                           range: NSRange(location: 0, length: attributedString.length))
            return attributedString.trimmedAttributedString(set: CharacterSet.whitespacesAndNewlines)
        } catch {
            return nil
        }
    }
}
