class CircularQueue
  def initialize(size)
    @size = size
    @curr_pointer = 0
    @old_pointer = 0
    @queue = initialize_queue(size)
  end

  def initialize_queue(size)
    (1..size).map { nil }
  end

  def enqueue(object)
    self.old_pointer = increment_pointer(curr_pointer) unless queue[curr_pointer].nil?

    queue[curr_pointer] = object
    self.curr_pointer = increment_pointer(curr_pointer)
  end

  def dequeue
    buffer = queue[old_pointer]
    queue[old_pointer] = nil
    self.old_pointer = increment_pointer(old_pointer) unless buffer == nil
    buffer
  end

  private

  attr_accessor :queue, :curr_pointer, :old_pointer

  def increment_pointer(location)
    (location + 1) % @size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil # true

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil


=begin
PROBLEM --------------------
create a circular queue  class that impliments a circule q for arbitrary objects such that:
if an empty space exists, that is where something is stored, if an empty space does not exist at the
  current location, the next entry is overwritten for that item

enqueue to add an object to the queue
dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty.

EXAMPLES -------------------


DATA STRUCTURES ------------
@queue is an array, of size init size

ALGORITHM ------------------
initialize the que with the size mapping nil
keep track of the size so that the que is never larger than that
also initialize a pointer int object to store what number object the que looks at

enqueue - check if there is anything at the current location. if not, add it there
          if yes, run the 'old_empty' method that returns either the first_nil or the next_object

dequeue - remove and return the next non-nil object

next_object - returns the next next non-nil object and deletes it from the queue

first_nil, iterate array size # of times, starting at the pointer to the current spot, and checking each
            object for 'nil'. reset the counter if the counter is equal to the array size
=end