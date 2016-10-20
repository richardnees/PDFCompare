import Cocoa
import Quartz
import PDFCompare

if
    let originalURL = Bundle.main.urlForImageResource("1"),
    let sameDataURL = Bundle.main.urlForImageResource("2"),
    let differectDataURL = Bundle.main.urlForImageResource("3"),
    let originalPDFDocument = PDFDocument(url: originalURL),
    let sameDataPDFDocument = PDFDocument(url: sameDataURL),
    let differectDataPDFDocument = PDFDocument(url: differectDataURL) {
    
    let compare1and1Data = originalPDFDocument.compareData(to: originalPDFDocument)
    let compare1and1Metadata = originalPDFDocument.compareMetadata(to: originalPDFDocument)

    let compare1and2Data = originalPDFDocument.compareData(to: sameDataPDFDocument)
    let compare1and2Metadata = originalPDFDocument.compareMetadata(to: sameDataPDFDocument)

    let compare1and3Data = originalPDFDocument.compareData(to: differectDataPDFDocument)
    let compare1and3Metadata = originalPDFDocument.compareMetadata(to: differectDataPDFDocument)
}
