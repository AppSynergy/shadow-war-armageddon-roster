import jsPDF from 'jspdf'

PDF =
  methods:
    makePDF: () ->
      pdf = new jsPDF 'landscape', 'mm', 'a4'
      html = document.querySelector 'div.roster-view'
      f = (dispose) -> pdf.save 'Test.pdf'
      pdf.fromHTML html, 0, 0, {}, f

export default PDF
