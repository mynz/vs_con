require 'pp'
require 'win32ole'
require 'optparse'

def get_dte()
    # return WIN32OLE.connect("VisualStudio.DTE.14.0") # for VS2015
    # return WIN32OLE.connect("VisualStudio.DTE.15.6") # for VS2017
    # return WIN32OLE.connect("VisualStudio.DTE.15.0") # for VS2017
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

	path = File.absolute_path(path)

	dte = get_dte

	io = dte.ItemOperations
	io.OpenFile path
	dte.ActiveDocument.Selection.MoveToLineAndOffset(row, col)
	dte.MainWindow.Activate()
end

opt = OptionParser.new
opt.on('-g', '--getfile') { |v| get_file() }
opt.on('-p', '--putfile') { |v| put_file(*ARGV) }

opt.parse!(ARGV)
