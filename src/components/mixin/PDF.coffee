import html2canvas from 'html2canvas'
import jsPDF from 'jspdf'

window.html2canvas = html2canvas

PDF =
  methods:
    makePDF: (fileName) ->
      pdf = new jsPDF 'landscape', 'mm', 'a4'
      ele = document.querySelector '.roster-view'
      pdf.addHTML ele, () -> pdf.save fileName

export default PDF
