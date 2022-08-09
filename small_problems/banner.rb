class Banner
  MAX_WIDTH = 80

  def initialize(message, width=message.size)
    width = MAX_WIDTH if width > MAX_WIDTH
    @message = message
    @width = width < message.size ? message.size : width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @width}-+" 
  end

  def empty_line
    "| #{' ' * @width} |" 
  end

  def message_line
    "| #{@message.center(@width)} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 1000)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+