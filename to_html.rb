builder = Nokogiri::HTML::Builder.new do |doc|
  doc.html {
    doc.body(:onload => 'some_func();') {
      doc.span.bold {
        doc.text "Hello world"
      }
    }
  }
end