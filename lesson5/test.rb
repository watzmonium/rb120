SQUARE_ORDER = 3
poop = [1, SQUARE_ORDER].each_with_object([]) do |start, ary|
  if start == 1
    ary << start.step(by: (SQUARE_ORDER + 1)).take(SQUARE_ORDER)
  else
    ary << SQUARE_ORDER.step(by: (SQUARE_ORDER - 1)).take(SQUARE_ORDER)
  end
end

p poop
