/*:
 # PDFCompare
 Isn't **this** ***amazing***?
*/

import Cocoa
import Quartz
import PDFCompare

guard let originalURL = Bundle.main.urlForImageResource(NSImage.Name("1")) else {
    print("Missing originalURL")
    exit(0)
}

guard let sameDataURL = Bundle.main.urlForImageResource(NSImage.Name("2")) else {
    print("Missing sameDataURL")
    exit(0)
}

guard let differentDataURL = Bundle.main.urlForImageResource(NSImage.Name("3")) else {
    print("Missing differentDataURL")
    exit(0)
}

guard let originalPDFDocument = PDFDocument(url: originalURL) else {
    print("Missing originalPDFDocument")
    exit(0)
}

guard let sameDataPDFDocument = PDFDocument(url: sameDataURL) else {
    print("Missing sameDataPDFDocument")
    exit(0)
}

guard let differentDataPDFDocument = PDFDocument(url: differentDataURL) else {
    print("Missing differentDataPDFDocument")
    exit(0)
}

let a = originalPDFDocument.compareData(to: originalPDFDocument)
let b = originalPDFDocument.compareMetadata(to: originalPDFDocument)

let c = originalPDFDocument.compareData(to: sameDataPDFDocument)
let d = originalPDFDocument.compareMetadata(to: sameDataPDFDocument)

let e = originalPDFDocument.compareData(to: differentDataPDFDocument)
let f = originalPDFDocument.compareMetadata(to: differentDataPDFDocument)

