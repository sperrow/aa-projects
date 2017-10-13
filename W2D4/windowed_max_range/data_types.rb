class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @store = []
    @max = []
    @min = []
  end

  def push(el)
    if @max.empty? || @max.last <= el
      @max << el
    end
    if @min.empty? || @min.last >= el
      @min << el
    end
    @store << el
  end

  def pop
    el = @store.pop
    @max.pop if max == el
    @min.pop if min == el
    el
  end

  def max
    @max.last
  end

  def min
    @min.last
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

# stack = MyStack.new
# stack.push(4)
# stack.push(7)
# stack.push(2)
# stack.push(6)
# stack.push(-1)
# stack.push(14)
# puts stack.max
# puts stack.min
# stack.pop
# puts stack.max
# puts stack.min
# stack.pop
# puts stack.max
# puts stack.min

class StackQueue
  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end

  def enqueue(el)
    @in_stack.push(el)
  end

  def dequeue
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.pop
  end

  def max
    maxes = []
    maxes << @in_stack.max unless @in_stack.empty?
    maxes << @out_stack.max unless @out_stack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @in_stack.min unless @in_stack.empty?
    mins << @out_stack.min unless @out_stack.empty?
    mins.min
  end

  def peek
    @out_stack.peek
  end

  def size
    @out_stack.size + @in_stack.size
  end

  def empty?
    @queue.empty?
  end
end

# stackqueue = StackQueue.new
# stackqueue.enqueue(4)
# puts stackqueue.max
# stackqueue.enqueue(-1)
# puts stackqueue.max
# stackqueue.enqueue(6)
# puts stackqueue.max
# stackqueue.enqueue(2)
# puts stackqueue.max
# puts stackqueue.min
# stackqueue.dequeue
# stackqueue.dequeue
# puts stackqueue.max
# puts stackqueue.min
