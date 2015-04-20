require './documentloader.rb'
require './noderenderer.rb'
require './treesearcher.rb'

Node = Struct.new(:name, :text, :classes, :id, :children, :parent, :elements_inside)

class DomReader

  attr_reader :page, :test_node, :document

  def initialize(document_name)
    @page = DocumentLoader.new(document_name).content
    @document = Node.new('document', nil, nil, nil, [], nil, @page)
    @test_node
    build_tree
  end

  # had some help from @schwad and @dsberger for this method's logic
  def build_tree
    node_queue = [@document]
    until node_queue.empty?
      current_node = node_queue.shift
      while children?(current_node)
        child_name = /<(\w+)\s*.*>/.match(current_node.elements_inside)[1]
        if child_name == 'li'
          inside_tag = /(<li.*?>.*?<\/li>)/.match(current_node.elements_inside)
        else
          inside_tag = /(<#{child_name}.*?>.*<\/#{child_name}>)/.match(current_node.elements_inside)
        end
        child_text = inside_tag[1]
        child = make_child(current_node, child_name, child_text)
        current_node.children << child
        node_queue << child
        current_node.elements_inside.gsub!(child_text, '')
      end
    end
  end

  def make_child(node, name, child_text)
    name = name
    text = /<#{name}.*?>(.*?)</.match(child_text)[1]
    classes = /<#{name} class="(.*?)">/.match(child_text)
    classes_fixed = classes[1].split(' ') if classes # I like these conditionals
    id = /<#{name} id ="(.*?)">/.match(child_text)
    tag_fixed = id[1].split(' ') if id
    children = []
    parent = node
    elements_inside = /<#{name}.*?>(.*)<\/#{name}>/.match(child_text)[1]

    if name == "ul"
      @test_node = Node.new(name, text, classes_fixed, tag_fixed, children, parent, elements_inside)
    end

    Node.new(name, text, classes_fixed, tag_fixed, children, parent, elements_inside)
  end

  def children?(node)
    node.elements_inside =~ /</
  end

end

test = DomReader.new("test.html")
NodeRenderer.new.render(test.test_node)

search = TreeSearcher.new(test)
puts "#{search.search_by(:text, "One h2")}"
puts "#{search.search_children(test.test_node, :text, 'One header')}"