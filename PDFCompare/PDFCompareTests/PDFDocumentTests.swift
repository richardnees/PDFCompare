import Quartz
import XCTest
@testable import PDFCompare

let testBundle = Bundle(for: PDFDocumentTests.self)

class PDFDocumentTests: XCTestCase {

    let originalPDFDocument = PDFDocument(url: testBundle.urlForImageResource("1")!)!
    let sameDataPDFDocument = PDFDocument(url: testBundle.urlForImageResource("2")!)!
    let differentDataPDFDocument = PDFDocument(url: testBundle.urlForImageResource("3")!)!

    override func setUp() {
        super.setUp()
        //
    }
    
    override func tearDown() {
        //
        super.tearDown()
    }
    
    func test_validateDataWithRegexFails() {
        let first = "1".data(using: .utf8)!
        let second = "2".data(using: .utf8)!
        
        let comparisonResult = originalPDFDocument.validate(selfData: first, otherData: second)
        XCTAssertFalse(comparisonResult)
    }

    func test_compareDataIdentical() {
        let comparisonResult = originalPDFDocument.compareData(to: originalPDFDocument)
        XCTAssertTrue(comparisonResult)
    }
    
    func test_compareDataEqual() {
        let comparisonResult = originalPDFDocument.compareData(to: sameDataPDFDocument)
        XCTAssertTrue(comparisonResult)
    }
    
    func test_compareDataDifferent() {
        let comparisonResult = originalPDFDocument.compareData(to: differentDataPDFDocument)
        XCTAssertFalse(comparisonResult)
    }

    func test_compareSelfMetadataEmpty() {
        let noMetadata = PDFDocument()
        let comparisonResult = noMetadata.compareMetadata(to: originalPDFDocument)
        XCTAssertFalse(comparisonResult)
    }

    func test_compareOtherMetadataEmpty() {
        let noMetadata = PDFDocument()
        let comparisonResult = originalPDFDocument.compareMetadata(to: noMetadata)
        XCTAssertFalse(comparisonResult)
    }

    func test_compareBothMetadataEmpty() {
        let noMetadata = PDFDocument()
        let comparisonResult = noMetadata.compareMetadata(to: noMetadata)
        XCTAssertFalse(comparisonResult)
    }

    func test_compareMetadataIdentical() {
        let comparisonResult = originalPDFDocument.compareMetadata(to: originalPDFDocument)
        XCTAssertTrue(comparisonResult)
    }

    func test_compareMetadataEqual() {
        let comparisonResult = originalPDFDocument.compareMetadata(to: sameDataPDFDocument)
        XCTAssertFalse(comparisonResult)
    }
    
    func test_compareMetadataDifferent() {
        let comparisonResult = originalPDFDocument.compareMetadata(to: differentDataPDFDocument)
        XCTAssertFalse(comparisonResult)
    }

}
