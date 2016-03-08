#!/usr/bin/env ruby

require 'json'
require 'liquid'

require_relative 'tags/justify_text'

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

Dir.mkdir('out') unless File.exist?('out') && File.directory?('out')

extensions.each do |e|
  temp = render_template(e)
  File.open('out/' + "resume.#{e}", 'w') do |file|
    file.write temp
  end
end
