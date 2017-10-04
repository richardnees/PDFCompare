import Foundation
import Quartz

func ==(lhs: [AnyHashable: Any], rhs: [AnyHashable: Any] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

// MARK: PDFDocument data comparison

public extension PDFDocument {
    
    /**
     Compares the metadata of another PDF document to itself
     
     - returns:
     A Bool indicating whether the metadata is exactly the same
     
     - parameters:
        - other: The PDF document to compare against
     
     */
    
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
    
    /**
     Compares the data of another PDF document to itself
     
     - returns:
     A Bool indicating whether the data is exactly the same
     
     - parameters:
        - other: The PDF document to compare against
     
     
     
     */
    
    public func compareData(to other: PDFDocument) -> Bool {
        guard
            let selfData = self.dataRepresentation(),
            let otherData = other.dataRepresentation(),
            selfData.count == otherData.count
            else {
                // Files have different byte count
                return false
        }
        
        return validate(lhsData: selfData, rhsData: otherData)
    }
    
    /**
     Validates the data of two PDF documents to determine whether they are equal regardless of the dynamic PDF file identifier
     
     - returns:
     A Bool indicating whether the two PDF data objects are equal disregarding the dynamic PDF file identifier
     
     - parameters:
        - lhsData: A PDF document
        - rhsData: Another PDF document
     
     */
    
    func validate(lhsData: Data, rhsData: Data) -> Bool {
        // Enumerate bytes to obtain a delta
        var deltaDataIndexes: [Int] = []
        for (index, lhsByte) in lhsData.enumerated() {
            let rhsByte = rhsData[index]
            if lhsByte != rhsByte {
                deltaDataIndexes.append(index)
            }
        }
        
        // Check delta index array, analyze string differences
        if
            let firstIndex = deltaDataIndexes.first,
            let lastIndex = deltaDataIndexes.last,
            let lhsDeltaString = String(data: lhsData.subdata(in: firstIndex..<lastIndex), encoding: .utf8),
            let rhsDeltaString = String(data: rhsData.subdata(in: firstIndex..<lastIndex), encoding: .utf8) {
            
            if isComparisonValid(string: lhsDeltaString) && isComparisonValid(string: rhsDeltaString) {
                return true
            }
        }
        
        return false
    }
    
    /**
     Compares a string to regex pattern of PDF file identifier
     
     - returns:
     A Bool indicating whether string matches pattern of PDF file identifier
     
     - parameters:
        - string: String to compare
     
     */
    
    func isComparisonValid(string: String) -> Bool {
        let regex = "^[a-f0-9]*>\\n<[a-f0-9]*"
        return string =~ regex
    }
}

