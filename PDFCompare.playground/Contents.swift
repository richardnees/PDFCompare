/*:
 # PDFCompare
 Isn't **this** ***amazing***?
*/

import Cocoa
import Quartz
import PDFCompare

if
    let originalURL = Bundle.main.urlForImageResource("1"),
    let sameDataURL = Bundle.main.urlForImageResource("2"),
    let differentDataURL = Bundle.main.urlForImageResource("3"),
    let originalPDFDocument = PDFDocument(url: originalURL),
    let sameDataPDFDocument = PDFDocument(url: sameDataURL),
    let differentDataPDFDocument = PDFDocument(url: differentDataURL) {
    
    let compare1and1Data = originalPDFDocument.compareData(to: originalPDFDocument)
    let compare1and1Metadata = originalPDFDocument.compareMetadata(to: originalPDFDocument)

    let compare1and2Data = originalPDFDocument.compareData(to: sameDataPDFDocument)
    let compare1and2Metadata = originalPDFDocument.compareMetadata(to: sameDataPDFDocument)

    let compare1and3Data = originalPDFDocument.compareData(to: differentDataPDFDocument)
    let compare1and3Metadata = originalPDFDocument.compareMetadata(to: differentDataPDFDocument)
}
