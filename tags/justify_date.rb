require 'date'

class JustifyDate < Liquid::Tag
  MAX_LENGTH = 80

  def initialize(tag_name, args, tokens)
    super
    vals = args.split(' ')
    @text = vals[0]
    @date = vals[1]
  end

  def render(context)
    text = context[@text.strip]
    date = Time.new(context[@date.strip]).strftime('%b %Y')

    result = text
    spaces = MAX_LENGTH - text.size - date.size
    spaces.times do
      result += ' '
    end
    result += date
  end
end

Liquid::Template.register_tag('justify_date', JustifyDate)
