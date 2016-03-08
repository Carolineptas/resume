require 'date'

class JustifyDateRange < Liquid::Tag
  MAX_LENGTH = 80

  def initialize(tag_name, args, tokens)
    super
    vals = args.split(' ')
    @text = vals[0]
    @start_date = vals[1]
    @end_date = vals[2]
  end

  def render(context)
    text = context[@text.strip]
    start_date = Time.new(context[@start_date.strip]).strftime('%b %Y')
    end_date = Time.new(context[@end_date.strip]).strftime('%b %Y')

    result = text
    spaces = MAX_LENGTH - text.size - start_date.size - end_date.size - 4
    spaces.times do
      result += ' '
    end
    result += start_date + ' to ' + end_date
  end
end

Liquid::Template.register_tag('justify_daterange', JustifyDateRange)
