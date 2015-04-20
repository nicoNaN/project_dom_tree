class DocumentLoader

  attr_reader :content

  def initialize(document)
    @content = File.open(document, 'r+') { |file| file.read }
    @content.gsub!(/\n\s*/, '') # easier to deal with if it's one long string
  end

end
