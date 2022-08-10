a = LoadError.new
p a.backtrace

begin
  # some code at risk of failing
rescue TypeError
  # take action
rescue ArgumentError
  # take a different action
end

begin
  # code at risk of failing here
rescue StandardError => e   # storing the exception object in e
  puts e.message            # output error message
end

file = open(file_name, 'w')
begin
  # do something with file
rescue
  # handle exception
rescue
  # handle a different exception
ensure
  file.close
  # executes every time
end

  def validate_age(age)
    raise("invalid age") unless (0..105).include?(age)
  end

  begin
    validate_age(age)
  rescue RuntimeError => e
    puts e.message              #=> "invalid age"
  end

PUTS 'You may always choose to be more specific about which type of 
exception to handle, but remember to never rescue the Exception class.'

