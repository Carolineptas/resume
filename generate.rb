#!/usr/bin/env ruby

require 'json'
require 'liquid'

def load_json(filename)
  File.open(filename, 'r') do |f|
    @json_resume = JSON.load(f)
  end
end

load_json('resume.json')
html_template = File.read('resume.html.liquid')
template = Liquid::Template.parse(html_template)

puts template.render('resume' => @json_resume)
