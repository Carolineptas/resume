#!/usr/bin/env ruby

require 'json'
require 'liquid'
require 'sass'

require_relative 'tags/fixed_width'
require_relative 'tags/justify_date'
require_relative 'tags/justify_daterange'
require_relative 'tags/justify_text'
require_relative 'tags/wrap_text'

def load_json(filename)
  File.open(filename, 'r') do |f|
    @json_resume = JSON.load(f)
  end
end

def render_txt
  tmp_file = File.read('templates/txt/resume.txt.liquid')
  template = Liquid::Template.parse(tmp_file)

  File.open('out/resume.txt', 'w') do |file|
    file.write template.render('resume' => @json_resume)
  end
end

def render_html
  tmp_file = File.read('templates/html/resume.html.liquid')
  template = Liquid::Template.parse(tmp_file)

  scss = File.read('templates/html/style.scss')
  css = Sass::Engine.new(scss, syntax: :scss).render

  File.open('out/resume.html', 'w') do |file|
    file.write template.render('resume' => @json_resume, 'style' => css)
  end
end

def render_tex
  tmp_file = File.read('templates/tex/resume.tex.liquid')
  template = Liquid::Template.parse(tmp_file)

  File.open('out/resume.tex', 'w') do |file|
    file.write template.render('resume' => @json_resume)
  end
end

def generate
  Dir.mkdir('out') unless File.exist?('out') && File.directory?('out')

  load_json('resume.json')
  render_txt
  render_html
  render_tex
end

generate
