class JustifyText < Liquid::Tag
  MAX_LENGTH = 80

  def initialize(tag_name, args, tokens)
    super
    @left = args.split(' ').first
    @right = args.split(' ').last
  end

  def render(context)
    left = context[@left.strip]
    right = context[@right.strip]

    result = left
    spaces = MAX_LENGTH - left.size - right.size
    spaces.times do
      result += ' '
    end
    result += right
  end
end

Liquid::Template.register_tag('justify_text', JustifyText)
