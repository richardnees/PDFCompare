import Cocoa
import Quartz
import PDFCompare

class ComparisonViewController: NSViewController {
    
    @IBOutlet var lhsImageView: PDFDropView!
    @IBOutlet var rhsImageView: PDFDropView!
    @IBOutlet var resultLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lhsImageView.delegate = self
        rhsImageView.delegate = self
    }
}

extension ComparisonViewController: PDFDropViewDelegate {
    func didDrag(pdfDropView: PDFDropView) {
        
        guard
            let lhsPDFData = lhsImageView.image?.representations.filter({ $0 is NSPDFImageRep }).first as? NSPDFImageRep,
            let rhsPDFData = rhsImageView.image?.representations.filter({ $0 is NSPDFImageRep }).first as? NSPDFImageRep,
            let lhsPDFDoc = PDFDocument(data: lhsPDFData.pdfRepresentation),
            let rhsPDFDoc = PDFDocument(data: rhsPDFData.pdfRepresentation)
            else {
                resultLabel.stringValue = ""
                return
        }

        resultLabel.stringValue = lhsPDFDoc.compareData(to: rhsPDFDoc) ? "PDF Data is the same" : "PDF Data is not the same"
    }
}
