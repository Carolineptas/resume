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

def escape_tex(input = '')
  input.values.map { |i| escape_tex(i) } if input.is_a?(Hash)
  input.map { |j| escape_tex(j) } if input.is_a?(Array)
  if input.is_a?(String)
    input.gsub!(/&/, '\\\\&')
    input.gsub!(/LaTeX/, '\\\\LaTeX\\\\')
    input.gsub!(/#/, '\\\\#')
    input.gsub!(/\$/, '\\\\$')
  end
  input
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
  escape_tex(@json_resume)
  tmp_file = File.read('templates/tex/resume.tex.liquid')
  template = Liquid::Template.parse(tmp_file)

  File.open('out/resume.tex', 'w') do |file|
    file.write template.render('resume' => @json_resume)
  end
end

def create_pdf
  system 'xelatex -shell-escape out/resume.tex'
  system 'mv resume.pdf out/'
  system 'rm *.aux'
  system 'rm *.log'
end

def generate
  Dir.mkdir('out') unless File.exist?('out') && File.directory?('out')

  load_json('resume.json')
  render_txt
  render_html
  render_tex
  create_pdf
end

generate
