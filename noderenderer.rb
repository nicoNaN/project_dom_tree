class NodeRenderer

  def initialize
  end

  def render(node)
    puts "Current node's..."
    puts "name: #{node.name}"
    puts "text: #{node.text}" if node.text
    puts "classes: #{node.classes}" if node.classes
    puts "ID: #{node.id}" if node.id

    node_queue = []

    node.children.each { |child| node_queue << child }

    sum = 0
    until node_queue.empty?
      current_node = node_queue.shift
      node_queue += current_node.children.each { |child| node_queue << child }
      sum += 1
    end
    puts "number of child nodes: #{sum}"
  end

end
