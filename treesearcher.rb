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

  def a_search_name(root, query)
    matches = []
    until root.parent == nil
      if root.name == query
        matches << root.name
      end
      root = root.parent
    end
    return matches
  end

  def a_search_text(root, query)
    matches = []
    until root.parent == nil
      if root.text == query
        matches << root.text
      end
      root = root.parent
    end
    return matches
  end

  def a_search_id(root, query)
    matches = []
    until root.parent == nil
      if root.id == query
        matches << root.id
      end
      root = root.parent
    end
    return matches
  end

  def a_search_class(root, query)
    matches = []
    until root.parent == nil
      if root.class == query
        matches << root.class
      end
      root = root.parent
    end
    return matches
  end

  def search_name(root, query)
    node_queue = [root]
    matches = []
    until node_queue.empty?
      current_node = node_queue.shift
      if current_node.name == query
        matches << current_node.name
      end
      node_queue += current_node.children.map(&:dup)
    end
    return matches
  end

  def search_text(root, query)
    node_queue = [root]
    matches = []
    until node_queue.empty?
      current_node = node_queue.shift
      if current_node.text == query
        matches << current_node.text
      end
      node_queue += current_node.children.map(&:dup)
    end
    return matches
  end

  def search_id(root, query)
    node_queue = [root]
    matches = []
    until node_queue.empty?
      current_node = node_queue.shift
      if current_node.id == query
        matches << current_node.id
      end
      node_queue += current_node.children.map(&:dup)
    end
    return matches
  end

  def search_class(root, query)
    node_queue = [root]
    matches = []
    until node_queue.empty?
      current_node = node_queue.shift
      if current_node.class == query
        matches << current_node.class
      end
      node_queue += current_node.children.map(&:dup)
    end
    return matches
  end

end