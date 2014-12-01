require 'pp'
require 'win32ole'
require 'optparse'

def get_dte()
	 return WIN32OLE.connect("VisualStudio.DTE")
end

def get_file
	dte = get_dte
	doc = dte.ActiveDocument
	path = doc.FullName
	pt = doc.Selection.ActivePoint
	row, col = pt.Line, pt.DisplayColumn
	puts "#{path},#{row},#{col}"
end

def put_file(path, row=1, col=1)
	return unless File.file? path

	pp path
	path = File.absolute_path(path)

	dte = get_dte
	dte.Documents.Open(path)
	dte.ActiveDocument.Selection.MoveToLineAndOffset(row, col)
end

opt = OptionParser.new
opt.on('-g', '--getfile') { |v| get_file() }
opt.on('-p', '--putfile') { |v| put_file(*ARGV) }

opt.parse!(ARGV)
