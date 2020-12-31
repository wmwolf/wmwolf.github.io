#! /usr/bin/env ruby
require_relative 'gen_quiz'
require 'fileutils'

class String
  def is_hidden_file?
    self[0] == '.'
  end
end

class TopicTree
  IGNORE_FIELDS = ['template', 'sample']

  attr_reader :fields, :subfields, :topics, :files, :base_dir

  def initialize(code, start_dir=File.join(File.dirname(__FILE__), '..'))
    @code = code
    @base_dir = start_dir
    @notes_dir = File.join(@base_dir, '_notes_source')
    @quiz_dir = File.join(@base_dir, '_quiz_source')
    @fields = []
    @subfields = {}
    @topics = {}
  end

  def topic_key(field, subfield)
    [field, subfield].join('_')
  end

  def build_tree!
    gather_fields
    gather_subfields
    gather_topics
    # gather_files
  end

  def gather_fields
    # first gather fields
    @fields = (Dir.entries(@notes_dir) + Dir.entries(@quiz_dir)).uniq
    @fields.map!(&:simple).uniq!
    @fields.reject! do |entry|
      IGNORE_FIELDS.include?(entry) || entry.is_hidden_file?
    end
  end

  def gather_subfields
    @fields.each do |field|
      # initialize empty arrays of subfields
      @subfields[field] = []

      # where to look for subfields
      field_notes_dir = File.join(@notes_dir, field)
      field_quiz_dir = File.join(@quiz_dir, field)
      
      # look in both notes and quiz directories
      [field_notes_dir, field_quiz_dir].each do |dir|
        if Dir.exist?(dir)
          Dir.entries(dir).reject(&:is_hidden_file?).each do |entry|
            @subfields[field] << entry
          end
        end
      end

      # get rid of duplicates
      @subfields[field] = @subfields[field].uniq
    end
  end

  def gather_topics
    @fields.each do |field|
      @subfields[field].each do |subfield|
        # initialize empty arrays of topics
        @topics[topic_key(field, subfield)] = []

        # where to look for subfields
        subfield_notes_dir = File.join(@notes_dir, field, subfield)
        subfield_quiz_dir = File.join(@quiz_dir, field, subfield)

        # look in both notes and quiz directories
        [subfield_notes_dir, subfield_quiz_dir].each do |dir|
          if Dir.exist?(dir)
            Dir.entries(dir).reject(&:is_hidden_file?).each do |entry|
              @topics[topic_key(field, subfield)] << entry
            end
          end
        end

        # sort topics if order file present in notes dir (really kludgy)
        if Dir.exist?(subfield_notes_dir)
          order_file = File.join(subfield_notes_dir, '.order.txt')
          if File.exist?(order_file)
            sorted_topics = File.read(order_file).downcase.split("\n")
            @topics[topic_key(field, subfield)].sort! do |t1, t2|
              if sorted_topics.include? t1.downcase
                if sorted_topics.include? t2.downcase
                  # both in sorted, thing, so use spaceship operator on index
                  sorted_topics.index(t1.downcase) <=> 
                    sorted_topics.index(t2.downcase)
                else
                  # t1 in, t2 not, so t2 goes at end
                  -1
                end
              elsif sorted_topics.include? t2.downcase
                # t2 in, t1 not, so t1 goes at end
                1
              else
                t1.downcase <=> t2.downcase
              end
            end
          end
        end


        # get rid of duplicates
        @topics[topic_key(field, subfield)] = 
          @topics[topic_key(field, subfield)].uniq
      end
    end
  end

  # creates quiz (js and html files) and returns path
  def create_quiz(field, subfield, topic)
    # bail out if we don't have a quiz
    return unless Dir.exist? File.join(@quiz_dir, field, subfield, topic)

    # punt to Quiz to create the js and html files, then return path to quiz
    Quiz.create_from_md(@base_dir, @code, field, subfield, topic)
    '/' + ['teaching', 'resources', @code, field, subfield, topic, 'quiz.html'].join('/')
  end

  def create_notes(field, subfield, topic)
    pdf_loc = File.join(@notes_dir, field, subfield, topic, topic + '.pdf')
    site_path = File.join(@base_dir, 'teaching', 'resources', @code, field, subfield, topic)
    new_loc = File.join(site_path, topic + '.pdf')
    # bail out if there are no notes
    return unless File.exist? pdf_loc

    # copy pdf to resources tree and return the path to notes
    FileUtils.mkdir_p site_path
    FileUtils.cp pdf_loc, new_loc
    '/' + 
      ['teaching', 'resources', @code, field, subfield, topic, topic + '.pdf'].join('/')
  end
end

class HTMLBuilder
  attr_reader :html
  def initialize(code)
    @html = ''
    @tree = TopicTree.new(code)
    @tree.build_tree!
    @code = code
    @indent = ''
  end

  def create_html
    add_header
    add_title
    add_navs
    add_fields
  end

  def save_html
    save_dir = File.join(@tree.base_dir, 'teaching', 'resources', @code)
    FileUtils.mkdir_p(save_dir)
    File.open(File.join(save_dir, 'index.html'), 'w') do |f|
      f.puts @html
    end
  end

  # shorthand to add a new line to html
  def ah(new_text)

    @html += (@indent + new_text + "\n")
  end

  # HTML helpers
  def inside_div(klass=nil, id=nil, &block)
    opening = '<div'
    opening += " class='#{klass}'" if klass
    opening += " id='#{id}'" if id
    opening += '>'

    ah opening
    old_indent = @indent.dup
    @indent += '  '
    block.call
    @indent = old_indent.dup
    ah '</div>'
  end

  def inside_row(klass=nil, id=nil, &block)
    row_class = "row"
    row_class += " #{klass}" unless klass.nil?
    inside_div(row_class, id, &block)
  end

  def inside_col(klass=nil, id=nil, &block)
    col_class = "col"
    col_class += " #{klass}" unless klass.nil?
    inside_div(col_class, id, &block)
  end

  def inside_row_col(row_class=nil, row_id=nil, col_class=nil, col_id=nil, &block)
    inside_row(row_class, row_id) do
      inside_col(col_class, col_id, &block)
    end
  end

  def anchor(href, text, klass=nil, id=nil)
    if klass.is_a? Array
      klass = klass.join(' ')
    end
    res = "<a href='#{href}'"
    res += " class = '#{klass}'" if klass
    res += " id = '#{id}'" if id
    res += ">#{text}</a>"
    res
  end

  # Building blocks of html
  def add_header
    ah "---"
    ah "layout: resources"
    ah "---"
  end

  def add_title
    inside_row_col { ah "<h1>Resources</h1>" }
  end

  def add_navs
    # no fields? we're screwed. Bail out
    return if @tree.fields.empty?
    # only one field? no need for navs
    return if @tree.fields.length == 1
    # inside_row_col do
      ah "<nav class='nav nav-pills nav-justified' id='subjects' role='navigation'>"

      # first, active field
      start_field = @tree.fields.first
      ah anchor('#', '<h3>'+start_field.complex+'</h3>',
        'nav-item nav-link active', "#{start_field.simple}-nav")

      # inactive fields
      @tree.fields[1..-1].each do |field|
        ah anchor('#', '<h3>' + field.complex + '</h3>', 'nav-item nav-link',
          "#{field.simple}-nav")
      end
      ah "</nav>"
    # end
  end

  def add_fields
    return if @tree.fields.nil? || @tree.fields.empty?
    @tree.fields.each do |field|
      inside_row_col('initially-hidden field', "#{field.simple}") do
        add_subfields(field)
      end
    end
  end

  def add_subfields(field)
    ah "<h2>#{field.complex} Subfields</h2>"
    @tree.subfields[field].each do |subfield|
      inside_div(nil, subfield.simple) do
        ah '<h4>'
        ah anchor('#', "<i class='fas fa-angle-right'></i>")
        ah subfield.complex
        ah '</h4>'
        add_topics(field, subfield)
      end
    end
  end

  def add_topics(field, subfield)
    topics = @tree.topics[@tree.topic_key(field, subfield)]
    return if topics.empty?
    inside_div('initially-hidden') do
      ah '<table class="table">'
      @indent += '  '
      ah '<thead class="thead-light">'
      @indent += '  '
      ah '<tr>'
      @indent += '  '
      ah '<th scope="col">Topic</th>'
      ah '<th scope="col" class="text-center">Quiz</th>'
      ah '<th scope="col" class="text-center">Notes</th>'
      @indent.chomp!('  ')
      ah '</tr>'
      @indent.chomp!('  ')
      ah '</thead>'
      ah '<tbody>'
      @indent += '  '
      topics.each do |topic|
        ah "<tr>"
        @indent += '  '
        ah '<td class="align-middle">' + topic.complex + '</td>'
        quiz_link = @tree.create_quiz(field, subfield, topic)
        notes_link = @tree.create_notes(field, subfield, topic)
        if quiz_link
          ah "<td class='align-middle text-center'>" +
          anchor(quiz_link, 'Take Quiz', 'btn btn-primary') + '</td>'
        else
          ah "<td class='align-middle'></td>"
        end

        if notes_link
          ah "<td class='align-middle text-center'>" + 
            anchor(notes_link, 'Get Notes', 'btn btn-success')
        else
          ah '<td class="align-middle"></td>'
        end
        @indent.chomp!('  ')
        ah "</tr>"
      end
      @indent.chomp!('  ')
      ah '</tbody>'
      @indent.chomp!('  ')
      ah '</table>'
    end
  end

end

class JSBuilder
  def initialize(code)
    @js = ''
    @tree = TopicTree.new(code)
    @tree.build_tree!
  end

  def create_js
    d_ready do
      reveal_first_field
      add_field_click_handlers
      add_subfield_click_handlers
    end
  end

  def save_js
    File.open(File.join(@tree.base_dir, 'js', 'resources.js'), 'w') do |f|
      f.puts @js
    end
  end


  # add code without a newline
  def aj(new_code)
    @js += '  ' + new_code
  end

  # add code with a newline
  def ajn(new_code)
    aj(new_code)
    @js += "\n"
  end

  # create anonymous function and allow block to insert code inside
  def func(indent = '', &block)
    @js += "function() {\n"
    block.call
    aj(indent + '}')
  end

  # create anonymous function as the last argument to another function
  def func_arg(indent = '', &block)
    func(indent, &block)
    @js += ");\n"
  end

  # boilerplate document(ready) that everything goes in
  def d_ready(&block)
    @js += '$(document).ready('
    func_arg(&block)
  end

  def reveal_first_field
    # we're screwed if there are no fields, so bail
    return if @tree.fields.empty?

    ajn "$('\##{@tree.fields.first.simple}').fadeIn(200);"
  end

  def add_field_click_handler(new_field)
    aj "$('\##{new_field.simple}-nav').click("
    func_arg do
      # deactivate all other fields in nav
      @tree.fields.reject { |field| field == new_field }.each do |field|
        ajn("  $('\##{field.simple}-nav').removeClass('active');")
      end

      # activate this field in nav
      ajn "  $('\##{new_field.simple}-nav').addClass('active');"

      # deactivate all fields in body
      aj "  $('.field').not('\##{new_field.simple}').fadeOut(200, "
      func_arg('  ') do
        # then, activate the new field
        ajn "    $('\##{new_field.simple}').fadeIn(200);"
      end
    end
  end

  def add_field_click_handlers
    return if @tree.fields.empty?
    @tree.fields.each { |field| add_field_click_handler(field) }
  end

  def add_subfield_click_handler(field, subfield)
    # CSS selector for subfield div within field div
    pre_selector = "\##{field.simple} \##{subfield.simple}"
    aj "$('#{pre_selector} a').click("
    func_arg do
      ajn "  $('#{pre_selector} i').toggleClass('fa-angle-right');"
      ajn "  $('#{pre_selector} i').toggleClass('fa-angle-down');"
      ajn "  $('#{pre_selector} .initially-hidden').slideToggle(200);"
    end
  end

  def add_subfield_click_handlers
    return if @tree.fields.empty?
    @tree.fields.each do |field|
      next if @tree.subfields[field].empty?
      @tree.subfields[field].each do |subfield|
        add_subfield_click_handler(field, subfield)
      end
    end
  end
end

def delete_old_resources
  safe = ['index.html', 'free']
  resource_dir = File.join(File.dirname(__FILE__), '..', 'teaching', 'resources')
  Dir.entries(resource_dir).reject(&:is_hidden_file?).reject do |entry| 
    safe.include? entry
  end.each { |entry| FileUtils.rm_rf File.join(resource_dir, entry) }
end

def update_auth_js(username=nil, password=nil, code=nil)
  js_file = File.join(File.dirname(__FILE__), '..', 'js', 'auth.js')
  contents = File.read(js_file)
  contents.sub!(/username: '[^']+'/, "username: '#{username}'") if username
  contents.sub!(/password: '[^']+'/, "password: '#{password}'") if password
  contents.sub!(/prefix: '[^']+'/, "prefix: '#{code}'") if code
  File.open(js_file, 'w') do |f|
    f.puts contents
  end
end

def update_all_resources(code:'default', username: nil, password: nil)
  delete_old_resources
  jb = JSBuilder.new(code)
  jb.create_js
  jb.save_js

  hb = HTMLBuilder.new(code)
  hb.create_html
  hb.save_html

  update_auth_js(username, password, code)
end

raise "Invalid arguments: #{ARGV[0]}, #{ARGV[1]}, and #{ARGV[2]} for " +
  "username, password, and code." unless (ARGV[0].is_a?(String) &&
   ARGV[1].is_a?(String) && ARGV[2].is_a?(String))

update_all_resources(username: ARGV[0], password: ARGV[1], code: ARGV[2])