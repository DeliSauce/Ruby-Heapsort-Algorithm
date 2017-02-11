require_relative "heap"

class Array
  def heap_sort!
    prc_max = Proc.new{|a,b| b <=> a}
    
    #max heap, left to right, heapify up
    (1...length).each do |index|
      BinaryMinHeap.heapify_up(self, index, &prc_max)
      p self
    end

    #max heap, right to left, heapify down
    (self.length - 1).downto(0) do |index|
      self[0], self[index] = self[index], self[0]
      BinaryMinHeap.heapify_down(self, 0, index, &prc_max)
      p self
    end

  end

end
