class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    removed = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &prc)
    return removed
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child_1 = parent_index * 2 + 1
    child_2 = parent_index * 2 + 2
    if len > child_2
      [child_1, child_2]
    elsif len > child_1
      [child_1]
    else
      []
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    children = BinaryMinHeap.child_indices(len, parent_idx)

    if children.length == 0
      return array
    elsif children.length == 1
      if prc.call(array[parent_idx], array[children[0]]) > 0
        array[parent_idx], array[children[0]] = array[children[0]], array[parent_idx]
      end
    else
      if prc.call(array[children[0]], array[children[1]]) > 0
        swap_index = children[1]
      else
        swap_index = children[0]
      end
      if prc.call(array[parent_idx], array[swap_index]) > 0
        array[parent_idx], array[swap_index] = array[swap_index], array[parent_idx]
        heapify_down(array, swap_index, len, &prc)
      end
    end

    return array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    return array if child_idx == 0

    swap_index = parent_index(child_idx)
    if prc.call(array[swap_index], array[child_idx]) > 0
      array[swap_index], array[child_idx] = array[child_idx], array[swap_index]
      heapify_up(array, swap_index, len, &prc)
    else
      return array
    end
  end
end
