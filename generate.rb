#!/usr/bin/env ruby

require 'json'
require 'liquid'

def load_json(filename)
  File.open(filename, 'r') do |f|
    @json_resume = JSON.load(f)
  end
end

def render_template(ext)
  tmp_file = File.read("templates/#{ext}/resume.#{ext}.liquid")
  template = Liquid::Template.parse(tmp_file)
  template.render('resume' => @json_resume)
end

load_json('resume.json')
extensions = %w(html tex txt)

extensions.each do |f|
  puts render_template(f)
end
