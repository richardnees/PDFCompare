import Foundation
import Quartz

func ==(lhs: [AnyHashable: Any], rhs: [AnyHashable: Any] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

// MARK: PDFDocument data comparison

public extension PDFDocument {
    
    public func compareMetadata(to other: PDFDocument) -> Bool {
        guard
            let selfDocumentAttributes = self.documentAttributes,
            selfDocumentAttributes.count > 0,
            let otherDocumentAttributes = other.documentAttributes,
            otherDocumentAttributes.count > 0 else {
                return false
        }
        
        return selfDocumentAttributes == otherDocumentAttributes
    }

    public func compareData(to other: PDFDocument) -> Bool {
        guard
            let selfData = self.dataRepresentation(),
            let otherData = other.dataRepresentation(),
            selfData.count == otherData.count
            else {
                // Files have different byte count
                return false
        }
        
        return validate(selfData: selfData, otherData: otherData)
    }
    
    func validate(selfData: Data, otherData: Data) -> Bool {
        // Enumerate bytes to obtain a delta
        var deltaDataIndexes: [Int] = []
        for (index, selfByte) in selfData.enumerated() {
            let otherByte = otherData[index]
            if selfByte != otherByte {
                deltaDataIndexes.append(index)
            }
        }
        
        // Check delta index array, analyze string differences
        if
            let firstIndex = deltaDataIndexes.first,
            let lastIndex = deltaDataIndexes.last,
            let selfDeltaString = String(data: selfData.subdata(in: firstIndex..<lastIndex), encoding: .utf8),
            let otherDeltaString = String(data: otherData.subdata(in: firstIndex..<lastIndex), encoding: .utf8) {
            
            if isComparisonValid(string: selfDeltaString) && isComparisonValid(string: otherDeltaString) {
                return true
            }
        }
        
        return false
    }
    
    func isComparisonValid(string: String) -> Bool {
        let regex = "^[a-f0-9]*>\\n<[a-f0-9]*"
        return string =~ regex
    }
}
