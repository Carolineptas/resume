class HyperRef < Liquid::Tag
  def initialize(tag_name, args, tokens)
    super
    vals = args.split(' ')
    @href = vals[0]
    @label = vals[1]
  end

  def render(context)
    href = context[@href.strip]
    label = context[@label.strip]

    if href =~ /@/
      "\\href\{mailto:#{href}\}\{#{label}\}"
    else
      "\\href\{#{href}\}\{#{label}\}"
    end
  end
end

Liquid::Template.register_tag('hyper_ref', HyperRef)
