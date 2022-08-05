def rev(string)
  string.split.map { |word| word.length > 4 ? word.reverse : word }.join(' ')
end

puts rev('hello i am a poopy butt boy')
