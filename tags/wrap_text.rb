class WrapText < Liquid::Tag
  MAX_LENGTH = 80

  def initialize(tag_name, arg, tokens)
    super
    @text = arg
  end

  def render(context)
    words = context[@text.strip].scan(/\S+/)
    line_len = 0
    output = ''
    words.each_with_index do |w, i|
      if (line_len + w.length + 1) >= MAX_LENGTH
        output += "\n"
        line_len = 0
      end
      if i < words.length - 1 && (line_len + w.length + 1 + words[i + 1].length) < MAX_LENGTH
        w += ' '
      end
      output += w
      line_len += w.length
    end
    output.strip
  end
end

Liquid::Template.register_tag('wrap_text', WrapText)
