require 'fileutils'

class String
  def simple
    gsub(/\s+/, '_').downcase
  end
  def quote
    unless include? "'"
      return "'" + self + "'"
    end
    unless include? '"'
      return '"' + self + '"'
    end
    raise "Don't know how to put quotes around the following string:\n#{self}"
  end

  def complex
    gsub('_', ' ').titleize
  end

  def titleize
    return self if empty?
    blacklist = %w(a an and at by for from nor of on or so the to yet)
    words = split
    words.each do |word|
      word.capitalize! unless blacklist.include? word.gsub(/\W/, '')
      if word =~ /^[1-9]d$/
        word.upcase!
      end
    end
    words[0].capitalize!
    words[-1].capitalize!
    words[0].upcase! if words[0] =~ /^\dd$/
    words[-1].upcase! if words[-1] =~ /^\dd$/
    words.join(' ')
  end
end

class Quiz < Object
  attr_accessor :field, :subfield, :topic, :questions, :base_dir,
    :resource_code, :images_dir

  def self.from_md(base_dir, resource_code, field, subfield, topic)
    new_quiz = Quiz.new(base_dir, resource_code)
    new_quiz.field = field
    new_quiz.subfield = subfield
    new_quiz.topic = topic
    md_dir = File.join(base_dir, '_quiz_source', new_quiz.subpath)
    images_dir = File.join(md_dir, 'images')
    raise "Invalid Directory: #{md_dir}" unless Dir.exist? md_dir
    # find ordered or unordered files and make sure they are .md files
    md_files = if File.exist?(File.join(md_dir, 'order.txt'))
                 File.read(File.join(md_dir, 'order.txt')).split.select do |f|
                   f =~ /^.+\.md$/ || f =~ /^[^\.]+$/
                 end.map do |f|
                   File.join(md_dir, f.chomp('.md') + '.md')
                 end
               else
                 Dir.entries(md_dir).select { |f| f =~ /^.+\.md$/ }.map do |f|
                   File.join(md_dir, f)
                 end
               end
    raise "Couldn't find any .md files in #{md_dir}" if md_files.empty?

    md_files.each do |md_file|
      new_quiz.add_question(QuizQuestion.from_md(File.read(md_file)))
    end
    new_quiz.images_dir = images_dir
    new_quiz
  end

  def self.create_from_md(base_dir, resource_code, field, subfield,
                          topic)
    new_quiz = from_md(base_dir, resource_code, field, subfield, topic)
    new_quiz.make_html
    new_quiz.make_js
    new_quiz.copy_images
  end

  def initialize(base_dir, resource_code)
    @field = ''
    @subfield = ''
    @topic = ''
    @questions = []
    @js_dir = File.join(base_dir, 'js')
    @resources_dir = File.join(base_dir, 'teaching', 'resources', resource_code)
  end

  def add_question(new_question)
    @questions << new_question
  end

  def subpath
    File.join(*[field, subfield, topic].map(&:simple))
  end

  def make_path(start)
    FileUtils.mkdir_p File.join(start, *[field, subfield, topic].map(&:simple))
  end

  def make_html(simple: false)
    res = ''
    res += "---\n"
    if simple
      res += "layout: simple_quiz\n"
    else
      res += "layout: quiz\n"
    end
    res += "field: #{field.complex}\n" if field
    res += "subfield: #{subfield.complex}\n" if subfield
    res += "topic: #{topic.complex}\n" if topic
    res += "quiz_title: #{topic.complex}\n" if topic
    res += "title: #{topic.complex} Quiz\n" if topic
    res += "---\n"
    file_name = File.join(@resources_dir, subpath, 'quiz.html')
    make_path(@resources_dir)
    File.open(file_name, 'w') do |f|
      f.write(res)
    end
  end

  def make_js(shuffle: false)
    res = ''
    res += ('$(document).ready(function() {' + "\n")
    res += '  var questions = [];'
    res += "\n"

    # add questions one at a time
    questions.each do |q|
      res += ('  questions.push(' + q.to_js + ');' + "\n")
    end

    # make nav sidebar know about each question
    res += %q[  for (var i = 0; i < questions.length; i++) {] + "\n"
    res += %q{    $('#questions-nav').append('<a class="list-group-item list-group-item-action", data-position=' + i + ' href="#question">' + questions[i].q_title + '</a>');}
    res += '  }'

    # optionally shuffle questions
    if shuffle
      res += '  quiz.run_quiz(quiz.shuffle(questions));'
    else
      res += '  quiz.run_quiz(questions)'
    end
    res += "\n"
    res += '});'

    file_name = File.join(@js_dir, 'quizzes', subpath, 'quiz.js')
    make_path(File.join(@js_dir, 'quizzes'))
    File.open(file_name, 'w') do |f|
      f.write(res)
    end
  end

  def copy_images
    return if images_dir.nil? || !Dir.exist?(images_dir) || Dir.empty?(images_dir)
    new_dir = File.join(@resources_dir, subpath, File.basename(images_dir))
    FileUtils.cp_r(images_dir, new_dir)
  end
end

class QuizQuestion
  attr_accessor :q_title, :question, :options, :explanations, :correct_index,
    :image, :caption

  def self.from_md(text)
    in_options = false
    in_explanations = false
    q_title = ''
    question = ''
    options = []
    explanations = []
    correct_index = nil
    image = nil
    caption = nil
    text.split("\n").each do |line|
      if line.strip =~ /^#\s+(.+)$/
        q_title = Regexp.last_match[1]
      elsif line.strip =~ /^##\s+Options$/i
        in_options = true
        in_explanations = false
      elsif line.strip =~ /^##\s+Explanations$/i
        in_explanations = true
        in_options = false
      elsif !(in_options || in_explanations) && !line.strip.empty?
        question << (' ' + line.strip)
        question.strip!
      elsif in_options
        if line.strip =~ /\-\s+(.+)$/
          new_option = Regexp.last_match[1]
          if new_option[0] == '*'
            options << new_option[1..-1]
            correct_index = options.length - 1
          else
            options << new_option
          end
        elsif !options.empty? && !line.strip.empty?
          options[-1] = options[-1] + ' ' + line.strip
        elsif options.empty?
          raise "options must start with \"- \": #{line}"
        end
      elsif in_explanations
        if line.strip =~ /-\s+(.+)$/
          explanations << Regexp.last_match[1]
        elsif !explanations.empty? && !line.strip.empty?
          explanations[-1] = explanations[-1] + ' ' + line.strip
        elsif !explanations.empty?
          raise "explanations must start with \"- \": #{line}"
        end        
      end
    end
    unless correct_index
      raise "No correct answer provided. Indicated correct answer with " \
            "asterisk before option: #{q_title}"
    end
    new(q_title, question, options, explanations, correct_index, image, caption)
  end

  def initialize(q_title, question, options, explanations, correct_index,
    image = nil, caption = nil)
    @q_title = q_title
    @question = question
    @options = options
    @explanations = explanations
    @correct_index = correct_index
    @image = image
    @caption = caption
  end

  def to_js
    res = ''
    res += 'new quiz.QuizItem('
    res += q_title.quote
    res += ','
    res += question.quote
    res += ','
    res += '['
    res += options.map(&:quote).join(',')
    res += '],['
    res += explanations.map(&:quote).join(',')
    res += '],'
    res += "#{correct_index})"
  end
end
