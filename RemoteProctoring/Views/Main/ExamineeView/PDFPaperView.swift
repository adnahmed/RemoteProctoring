//
//  PDFPaperView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import SwiftUI
import PDFKit

struct PDFPaperView: View {
    var body: some View {
        Text("PDF Paper")
        ExamPDFView()
    }
    
    #if os(iOS)
    struct ExamPDFView: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            // TODO: Implement fetch pdf document here
            let pdfView = PDFView()
            pdfView.document = PDFDocument(url: URL(string: Network.shared.apiEndpoint.absoluteString + "/files/pdf/")!)
            return pdfView
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
            return
        }
    }
    #else
    struct ExamPDFView: NSViewRepresentable {
        func makeNSView(context: Context) -> some NSView {
             // TODO: Implement fetch pdf document here
            let pdfView = PDFView()
            pdfView.document = PDFDocument(url: URL(string: Network.shared.apiEndpoint.absoluteString + "/files/pdf/")!)
            return pdfView

        }
        func updateNSView(_ nsView: NSViewType, context: Context) {
            return
        }
    }
    #endif
}

#if DEBUG
struct PDFPaperView_Previews: PreviewProvider {
    static var previews: some View {
        PDFPaperView()
    }
}
#endif
