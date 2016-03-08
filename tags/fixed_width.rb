class FixedWidth < Liquid::Tag
  def initialize(tag_name, args, tokens)
    super
    @text = args.split(' ').first
    @len = args.split(' ').last.to_i
  end

  def render(context)
    text = context[@text.strip]
    result = text
    spaces = @len - text.length
    spaces.times do
      result += ' '
    end
    result
  end
end

Liquid::Template.register_tag('fixed_width', FixedWidth)
