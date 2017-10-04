import Cocoa

protocol PDFDropViewDelegate: NSObjectProtocol {
    func didDrag(pdfDropView: PDFDropView)
}

class PDFDropView: NSImageView {

    var delegate: PDFDropViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerForDraggedTypes([.pdf])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return NSDragOperation.every
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        delegate?.didDrag(pdfDropView: self)
    }
}
