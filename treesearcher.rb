class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(search_type, query)
    case search_type
    when :name
      search_name(@tree.document, query)
    when :text
      search_text(@tree.document, query)
    when :id
      search_id(@tree.document, query)
    when :class
      search_class(@tree.document, query)
    end
  end

  def search_children(node, search_type, query)
    case search_type
    when :name
      search_name(node, query)
    when :text
      search_text(node, query)
    when :id
      search_id(node, query)
    when :class
      search_class(node, query)
    end
  end

def search_ancestors(node, search_type, query)
    case search_type
    when :name
      a_search_name(node, query)
    when :text
      a_search_text(node, query)
    when :id
      a_search_id(node, query)
    when :class
      a_search_class(node, query)
    end
  end

  def a_search_helper(root, query, type)
    matches = []
    until root.parent == nil
      if yield(root, query)
        a_shovel_matches(matches, root, type)
      end
      root = root.parent
    end
    return matches
  end

  def a_shovel_matches(matches, node, type)
    case type
    when :name
      matches << node.name
    when :text
      matches << node.text
    when :id
      matches << node.id
    when :class
      matches << node.class
    end
  end

  def a_search_name(root, query)
    a_search_helper(root, query, :name) { |node, val| node.name == val }
  end

  def a_search_text(root, query)
    a_search_helper(root, query, :text) { |node, val| node.text == val }
  end

  def a_search_id(root, query)
    a_search_helper(root, query, :id) { |node, val| node.id == val }
  end

  def a_search_class(root, query)
    a_search_helper(root, query, :class) { |node, val| node.class == val }
  end

  def search_helper(root, query, type)
    node_queue = [root]
    matches = []
    until node_queue.empty?
      current_node = node_queue.shift
      if yield(current_node, query)
        shovel_matches(matches, current_node, type)
      end
      node_queue += current_node.children.map(&:dup)
    end
    return matches
  end

  def shovel_matches(matches, node, type)
    case type
    when :name
      matches << node.name
    when :text
      matches << node.text
    when :id
      matches << node.id
    when :class
      matches << node.class
    end
  end

  def search_name(root, query)
    search_helper(root, query, :name) { |node, val| node.name == val }
  end

  def search_text(root, query)
    search_helper(root, query, :text) { |node, val| node.text == val }
  end

  def search_id(root, query)
    search_helper(root, query, :id) { |node, val| node.id == val }
  end

  def search_class(root, query)
    search_helper(root, query, :class) { |node, val| node.class == val }
  end

end
