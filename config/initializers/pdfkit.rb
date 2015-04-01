# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  config.wkhtmltopdf = 'bin/wkhtmltopdf'
  config.default_options = {
   :encoding=> "UTF-8",
   :page_size=> "A4",
   :zoom => '1.0',
   :disable_smart_shrinking => false
  }
  # Use only if your external hostname is unavailable on the server.
  #config.root_url = "http://localhost"
  config.verbose = true
end