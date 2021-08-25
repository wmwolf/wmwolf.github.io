course_data = 
  MATH_112:
    field: 'MATH'
    number: 112
    name: 'Precalculus Mathematics'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: 'Prepares students to enter the Math 114, Math 215, Math 216 sequence. Includes absolute value; logarithmic, exponential, and trigonometric functions; inequalities; conic sections; complex numbers; and topics from theory of equations.'
    le: ['S2']
    requirements: null
    years_offered: 'all'
    terms_offered: 'all' 
  MATH_114:
    field: 'MATH'
    number: 114
    name: 'Calculus I'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: 'Limits, theory, and application of the derivative; introduction to integration.'
    le: ['S2']
    requirements:
      prereqs: ['MATH 112']
    years_offered: 'all'
    terms_offered: 'all'
  MATH_215:
    field: 'MATH'
    number: 215
    name: 'Calculus II'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Applications and techniques of integration; improper integrals; sequences and series; power series and Taylor's formula."
    le: ['S2']
    requirements:
      prereqs: ['MATH 114']
    years_offered: 'all'
    terms_offered: 'all'
  MATH_216:
    field: 'MATH'
    number: 216
    name: 'Calculus III'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Introduction to functions of several variables, including partial derivatives, multiple integrals, the calculus of vector-valued functions, and Green's Theorem, Stokes' Theorem, and the Divergence Theorem."
    le: []
    requirements:
      prereqs: ['MATH 215']
    years_offered: 'all'
    terms_offered: 'all'
  MATH_312:
    field: 'MATH'
    number: 312
    name: 'Differential Equations and Linear Algebra'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Linear algebra: basis, dimension, matrix algebra, determinants, inverses, systems of linear equations, eigenvalues/eigenvectors. (Optional) matrices as linear transformations. Differential equations: first-order linear, separable; second-order linear with constant coefficients; higher order differential equations; first-order linear systems with constant coefficients; Laplace transforms; power series solutions. (Optional) Proof of Existence and Uniqueness Theorems."
    le: []
    requirements:
      prereqs: ['MATH 215']
    years_offered: 'all'
    terms_offered: 'all'
  PHYS_186:
    field: 'PHYS'
    number: 186
    name: 'Introductory Seminar'
    lecture_hours: 0.5
    lab_hours: 0
    credits: 0.5
    description: "Students will explore avenues for obtaining an internship, discuss plans for participating in the required research project, attend the weekly Physics Seminar, develop academic plans, and participate in postgraduate planning."
    le: []
    requirements: null
    years_offered: 'all'
    terms_offered: 'fall'
  PHYS_231:
    field: 'PHYS'
    number: 231
    name: 'University Physics I'
    lecture_hours: 4
    lab_hours: 2
    credits: 5
    description: "Physics for science and engineering students, including the study of mechanics, simple harmonic motion, and wave motion."
    le: ['K1', 'K1L']
    requirements:
      coreqs: ['MATH 114']
    years_offered: 'all'
    terms_offered: 'all'
  PHYS_232:
    field: 'PHYS'
    number: 232
    name: 'University Physics II'
    lecture_hours: 4
    lab_hours: 2
    credits: 5
    description: "A continuation of Physics 231, including the study of electricity, magnetism, and optics."
    le: ['K1', 'K1L']
    requirements:
      coreqs: ['MATH 215'],
      prereqs: ['PHYS 231']
    years_offered: 'all'
    terms_offered: 'all'
  PHYS_240:
    field: 'PHYS'
    number: 240
    name: 'Computational Physics'
    lecture_hours: 2
    lab_hours: 2
    credits: 3
    description: "An introduction to the use of computational tools for solving physical problems. Topics include an introduction to computing, visualization techniques, numerical integration, and numerical solutions to differential equations."
    le: []
    requirements:
      prereqs: ['PHYS 231']
    years_offered: 'all'
    terms_offered: 'all'
  PHYS_255:
    field: 'PHYS'
    number: 255
    name: 'Statics'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Designed primarily for pre-engineering students. Includes static equilibrium of rigid bodies, centroids, analysis of structures, friction, and moments of inertia."
    le: []
    requirements: 
      prereqs: ['PHYS 231']
      coreqs: ['MATH 215']
    years_offered: 'all'
    terms_offered: 'fall'
  PHYS_332:
    field: 'PHYS'
    number: 332
    name: 'University Physics III'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Physics for science and engineering students, including the study of fluids, heat, thermodynamics, relativity, and an introduction to modern physics."
    le: ['I1']
    requirements: 
      prereqs: ['PHYS 232', 'MATH 215']
    years_offered: 'all'
    terms_offered: 'all'
  PHYS_333:
    field: 'PHYS'
    number: 333
    name: 'Quantum Physics'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Introduction to the experimental and theoretical basis of quantum physics, including particle aspects of radiation, matter waves, Bohr model of the atom, Schrodinger wave mechanics and its application to the hydrogen atom and multi-electron atoms."
    le: []
    requirements: 
      prereqs: ['PHYS 332', 'MATH 216']
    years_offered: 'even'
    terms_offered: 'fall'
  PHYS_340:
    field: 'PHYS'
    number: 340
    name: 'Optics'
    lecture_hours: 3
    lab_hours: 3
    credits: 4
    description: "Lecture and laboratory work cover geometrical and physical optics, image formation, optical instruments, interference, diffraction, polarization, and modern topics including lasers."
    le: []
    requirements: 
      prereqs: ['PHYS 232', 'MATH 215']
    years_offered: 'all'
    terms_offered: 'spring'

  PHYS_350:
    field: 'PHYS'
    number: 350
    name: 'Electric and Electronic Circuits'
    lecture_hours: 3
    lab_hours: 3
    credits: 4
    description: "General introduction to electrical circuits and electronics including analysis of DC and AC circuits, simple passive filters, diodes, transistors, operational amplifiers, simple digital electronics, and circuit design and construction."
    le: []
    requirements: 
      prereqs: ['PHYS 232', 'MATH 215']
    years_offered: 'all'
    terms_offered: 'fall'

  PHYS_356:
    field: 'PHYS'
    number: 356
    name: 'Dynamics'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "A continuation of Physics 255. Dynamics of rigid bodies, moments of inertia, work, energy, impulse, and momentum."
    le: []
    requirements: 
      prereqs: ['PHYS 255', 'MATH 215']
      exclude: ['PHYS 356']
    years_offered: 'all'
    terms_offered: 'spring'

  PHYS_360:
    field: 'PHYS'
    number: 360
    name: 'Electronics'
    lecture_hours: 3
    lab_hours: 3
    credits: 4
    description: "Description, analysis, and laboratory measurements of digital and analog devices including transistor amplifiers, operational amplifiers, oscillators, gates, flip-flops, analog-digital converters, and microprocessors."
    le: []
    requirements: 
      prereqs: ['PHYS 350', 'MATH 240']
    years_offered: 'all'
    terms_offered: 'spring'

  PHYS_360:
    field: 'PHYS'
    number: 360
    name: 'Electronics'
    lecture_hours: 3
    lab_hours: 3
    credits: 4
    description: "Description, analysis, and laboratory measurements of digital and analog devices including transistor amplifiers, operational amplifiers, oscillators, gates, flip-flops, analog-digital converters, and microprocessors."
    le: []
    requirements: 
      prereqs: ['PHYS 350', 'MATH 240']
    years_offered: 'all'
    terms_offered: 'spring'

  PHYS_361:
    field: 'PHYS'
    number: 361
    name: 'LabVIEW Basics'
    lecture_hours: 2
    lab_hours: 0
    credits: 2
    description: "Lecture and laboratory work cover an introduction to the graphical programming language LabVIEW. LabVIEW has been widely adopted as the industry standard for computerized data acquisition, analysis and instrument control."
    le: []
    requirements: 
      coreqs: ['PHYS 350']
    years_offered: 'all'
    terms_offered: 'fall'

  PHYS_362:
    field: 'PHYS'
    number: 362
    name: 'LabVIEW Applications'
    lecture_hours: 2
    lab_hours: 0
    credits: 2
    description: "Lecture and laboratory exercises cover applications using the graphical programming language LabVIEW. Topics include advanced programming structures, CompactDAQ hardware, digital signal processing, motor control, encoders, PID process control, RS-232 instrument control, component testing, sensor monitoring."
    le: []
    requirements: 
      prereqs: ['PHYS 361']
    years_offered: 'all'
    terms_offered: 'spring'

  PHYS_363:
    field: 'PHYS'
    number: 363
    name: 'LabVIEW cRIO'
    lecture_hours: 1
    lab_hours: 0
    credits: 1
    description: "Lecture and laboratory exercises cover the theory and application of the cRIO automation controller using the graphical programming language LabVIEW. Topics include Real-Time operating system, field programmable gate array (FPGA) and network shared variables."
    le: []
    requirements: 
      coreqs: ['PHYS 362']
    years_offered: 'all'
    terms_offered: 'spring'

  PHYS_365:
    field: 'PHYS'
    number: 365
    name: 'Theoretical Mechanics'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Newton's laws, accelerated frames, central-force orbits, angular momentum of systems, coupled oscillations, generalized coordinates, and Lagrange's equations."
    le: []
    requirements: 
      prereqs: ['MATH 216', 'PHYS 231', 'PHYS 240']
      exclude: ['PHYS 356']
    years_offered: 'all'
    terms_offered: 'fall'

  PHYS_367:
    field: 'PHYS'
    number: 367
    name: 'Astrophysics'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Physics applied to astronomical objects. The birth, structure, and evolution of stars are studied in detail. Nebulae, the interstellar medium, and stellar remnants are also investigated."
    le: []
    requirements: 
      prereqs: ['PHYS 240', 'PHYS 332']
    years_offered: 'odd'
    terms_offered: 'fall'

  PHYS_375:
    field: 'PHYS'
    number: 375
    name: 'Electromagnetic Fields'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Electric and magnetic fields, dielectric and magnetic properties of materials, and electromagnetic phenomena. Field theory leading to the development of Maxwell's equations and the plane electromagnetic wave."
    le: []
    requirements: 
      prereqs: ['PHYS 240', 'PHYS 332', 'MATH 216', 'MATH 312']
    years_offered: 'even'
    terms_offered: 'spring'

  PHYS_430:
    field: 'PHYS'
    number: 430
    name: 'Advanced Laboratory Technique'
    lecture_hours: 0
    lab_hours: 4
    credits: 2
    description: "Laboratory course for students with special interests in experimental physics. The emphasis is on widely applicable modern experimental methods."
    le: []
    requirements: 
      combo: 
        min: 2
        options: ['PHYS 340', 'PHYS 350', 'PHYS 360']
    years_offered: 'all'
    terms_offered: 'fall'

  PHYS_445:
    field: 'PHYS'
    number: 445
    name: 'Advanced Laboratory Technique'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Statistical mechanics and thermodynamics including the laws of classical thermodynamics, equations of state, thermodynamical processes, and applications to classical and quantum mechanical systems."
    le: []
    requirements: 
      prereqs: ['PHYS 332', 'MATH 216'] 
    years_offered: 'even'
    terms_offered: 'fall'

  PHYS_465:
    field: 'PHYS'
    number: 465
    name: 'Quantum Mechanics'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "A continuation of Physics 333, including Dirac notation, operator methods, one dimensional potentials, spin and angular momentum, and the philosophical interpretation of quantum mechanics."
    le: []
    requirements: 
      prereqs: ['PHYS 333', 'MATH 312'] 
    years_offered: 'odd'
    terms_offered: 'spring'

  PHYS_486:
    field: 'PHYS'
    number: 486
    name: 'Introductory Seminar'
    lecture_hours: 0.5
    lab_hours: 0
    credits: 0.5
    description: "Students will present a capstone project seminar, develop presentation skills (oral and poster), take a nationally normed test covering undergraduate physics, discuss their post-graduate plans, and assist the department in assessing the major."
    le: ['S3 Creativity']
    requirements:
      custom: 'Students need to have completed an adviser-approved capstone project before entering this class. This can be accomplished through various means: PHYS 399, PHYS 430, PHYS 495, PHYS 499, through an academic or industrial internship, or through another approved means.'
    years_offered: 'all'
    terms_offered: 'fall'



class Course
  constructor: (@course_info) ->
    # unpack course data object
    @field = @course_info.field
    @number = @course_info.number
    @name = @course_info.name
    @lecture_hours = @course_info.lecture_hours
    @lab_hours = @course_info.lab_hours
    @credits = @course_info.credits
    @description = @course_info.description
    @le = @course_info.le

    # designations are strings, regualar values hold actual courses
    # actual courses need to be set up later, since there's not guarantee 
    # the courses already exist, nor is there a way to get at them
    # 
    # prereqs: course must be taken BEFORE enrolling
    # coreqs: course must be taken BEFORE or WHILE enrolling
    # prereq_options: some number of these courses must be taken BEFORE enrolling
    # exclude: cannot enroll if any of these courses have been completed
    @prereq_designations = []
    @coreq_designations = []
    @combo_option_designations = []
    @exclude_designations = []

    @prereqs = []
    @coreqs = []
    @combo_options = []
    @combo_option_min = 0
    @exclusions = []

    unless @course_info.requirements == null
      unless @course_info.requirements.prereqs == undefined
        @prereq_designations = @course_info.requirements.prereqs

      unless @course_info.requirements.coreqs == undefined
        @coreq_designations = @course_info.requirements.coreqs

      unless @course_info.requirements.combo == undefined
        @combo_option_designations = @course_info.requirements.combo.options
        @combo_option_min = @course_info.requirements.combo.min

      unless @course_info.requirements.exclude == undefined
        @exclude_designations = @course_info.requirements.exclude

    @years_offered = @course_info.years_offered
    @terms_offered = @course_info.terms_offered

    # HTML helpers
    @context_classes = ['default', 'primary', 'secondary', 'success', 'warning', 'danger']
    @all_border_classes = (@context_classes.map (cls) -> 'border-' + cls).join(' ')
    @all_bg_classes = (@context_classes.map (cls) -> 'bg-' + cls).join(' ')
    @all_btn_classes = (@context_classes.map (cls) -> 'btn-' + cls).join(' ')

    # CSS IDs and Selectors
    @completed_id = "#{@field}-#{@number}-completed"
    @enrolling_id = "#{@field}-#{@number}-enrolling"
    @card_id = "#{@field}#{@number}"
    @modal_id = "#{@field}-#{@number}"

    @completed_sel = '#' + @completed_id
    @enrolling_sel = '#' + @enrolling_id
    @card_sel = '#' + @card_id
    @header_sel = @card_sel + '>h5.card-header'
    @modal_sel = '#' + @modal_id

    # state variables
    @completed = false
    @enrolling = false
    @year_term_taken = false

    # base HTML card
    @html_card = "<div class='card' id='#{@card_id}'>\n"
    @html_card += "  <h5 class='card-header'>#{@field} #{@number} <span class='font-italic'>(#{@credits} credits)</span></h5>\n"
    @html_card += "  <div class='card-body'>\n"
    @html_card += "    <h5 class='card-title'>#{@name}</h5>\n"
    # @html_card += "    <p class='card-text'>#{@description}</p>\n"
    @html_card += "    <div class='row'>\n"
    @html_card += "      <div class='col'>\n"
    @html_card += "        <button type='button' class='btn btn-sm description' id='#{@modal_id}'>Details</button>\n"
    @html_card += "     </div>\n"
    @html_card += "      <div class='col'>\n"
    @html_card += "        <div class='custom-control custom-switch'>\n"
    @html_card += "          <input type='checkbox' class='custom-control-input completed' id='#{@completed_id}'>\n"
    @html_card += "          <label for='#{@completed_id}' class='custom-control-label'>Completed</label>\n"
    @html_card += "        </div>\n"
    @html_card += "        <div class='custom-control custom-switch'>\n"
    @html_card += "          <input type='checkbox' class='custom-control-input enrolling' id='#{@enrolling_id}'>\n"
    @html_card += "          <label for='#{@enrolling_id}' class='custom-control-label'>Enrolling</label>\n"
    @html_card += "        </div>\n"
    @html_card += "      </div>\n"
    @html_card += "    </div>\n"
    @html_card += "  </div>\n"
    @html_card += "</div>"

  toggle_completed: ->
    @completed = not @completed

  toggle_enrolling: ->
    @enrolling = not @enrolling

  update_modal: (year_term) ->
    $('#course-info-label').html("#{@field} #{@number}: #{@name}")
    $('#course-description').html('')
    $('#course-description').append("<p>#{@description}</p>")
    $('#course-description').append("<p>Lecture Hours: #{@lecture_hours}; Lab Hours: #{@lab_hours}</p>")
    if @prereq_designations.length > 0
      $('#course-description').append("<p><span class='font-italic'>Prerequisites:</span> #{@prereq_designations.join(', ')}</p>")
    if @coreq_designations.length > 0
      $('#course-description').append("<p><span class='font-italic'>Corequisites:</span> #{@coreq_designations.join(', ')}</p>")
    availability = 'Offered '
    if @terms_offered == 'all'
      availability += 'every term.'
    else if @years_offered == 'all'
      availability += "in the <span class='font-weight-bold'>#{@terms_offered} term</span> every year."
    else
      availability += "in the <span class='font-weight-bold'>#{@terms_offered} term of #{@years_offered} years</span>."
    $('#course-description').append("<p>#{availability}</p>")
    $('#modal-enrolling').prop('disabled', !@available(year_term))


  # update coreqs and prereqs from list of courses. Uses designations to 
  # query an array of courses, and then makes the actual course objects the
  # prerequisistes, corequisites, etc.
  update_requirements: (courses)->
    unless @prereq_designations.length == 0
      for designation in @prereq_designations
        for course in courses
          if "#{course.field} #{course.number}" == designation
            @prereqs.push(course)
    for designation in @coreq_designations
      for course in courses
        if "#{course.field} #{course.number}" == designation
          @coreqs.push(course)
    for designation in @combo_option_designations
      for course in courses
        if "#{course.field} #{course.number}" == designation
          @combo_options.push(course)
    for designation in @exclude_designations
      for course in courses
        if "#{course.field} #{course.number}" == designation
          @exclusions.push(course)


  available: (year_term) ->
    year = year_term.year
    term = year_term.term
    res = true
    for prereq in @prereqs
      res = res && prereq.completed
    for coreq in @coreqs
      res = res && (coreq.completed || coreq.enrolling)

    # handle course with a minimum number of prerequisites from a collection
    # of courses
    combo_count = 0
    for combo_option in @combo_options
      if combo_option.completed
        combo_count += 1
    res = res && (combo_count >= @combo_option_min)

    # handle courses that exclude other courses (356 & 365)  
    for course in @exclusions
      res = res && !course.completed

    # offered this year?
    res = res && ((@years_offered == 'all') || \
      ((@years_offered == 'even') && (year % 2 == 0)) || \
      ((@years_offered == 'odd') && (year % 2 == 1)) )
    # offered this term?
    res = res && ((@terms_offered == 'all') || @terms_offered == year_term.term)
    res
    
  clear_formatting: ->
    $(@card_sel).removeClass(@all_border_classes)
    $(@header_sel).removeClass(@all_bg_classes)
    $(@header_sel).removeClass('text-white')
    $(@modal_sel).removeClass(@all_btn_classes)
    # $(@modal_sel).addClass('btn-secondary')

  mark_available: ->
    @completed = false
    @year_term_taken = false
    @enrolling = false
    @clear_formatting()
    $(@card_sel).addClass('border-warning')
    $(@header_sel).addClass('bg-warning text-white')
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', false)
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', false)
    $(@modal_sel).addClass('btn-warning')


  mark_unavailable: ->
    @completed = false
    @year_term_taken = false
    @enrolling = false
    @clear_formatting()
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', true)
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', false)
    $(@modal_sel).addClass('btn-secondary')

  mark_completed: (year_term) ->
    @completed = true
    @year_term_taken = year_term
    @enrolling = false
    @clear_formatting()
    $(@card_sel).addClass('border-success')
    $(@header_sel).addClass('bg-success text-white')
    $(@completed_sel).prop('checked', true)
    $(@enrolling_sel).prop('checked', false)
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', true)
    $(@modal_sel).addClass('btn-success')
    for course in @prereqs
      course.mark_completed(year_term)
    for course in @coreqs
      course.mark_completed(year_term)

  mark_enrolling: (year_term) ->
    @completed = false
    @year_term_taken = year_term
    @enrolling = true
    @clear_formatting()
    $(@card_sel).addClass('border-primary')
    $(@header_sel).addClass('bg-primary text-white')
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', true)
    $(@completed_sel).prop('disabled', true)
    $(@enrolling_sel).prop('disabled', false)
    $(@modal_sel).addClass('btn-primary')
    
  refresh: (old_year_term, new_year_term) ->

    # moving to future year? convert class from enrolling to taken
    if new_year_term.value() > old_year_term.value()
      if @enrolling
        @mark_completed(old_year_term)
        $(@enrolling_sel).prop('checked', @enrolling)
        $(@completed_sel).prop('checked', @completed)
      else if @completed
        if new_year_term.value() > @year_term_taken.value()
          @mark_completed(@year_term_taken)
      else if @available(new_year_term)
        @mark_available()
      else
        @mark_unavailable()
  
    # staying in the same year-term (changed status of one course)
    else if new_year_term.value() == old_year_term.value()
      if @completed
        if !@year_term_taken
          # probably just marked completed; reflect in the data
          @mark_completed(old_year_term)
        else
          @mark_completed(@year_term_taken)
      else if @enrolling
        @mark_enrolling(new_year_term)
      else if @available(new_year_term)
        @mark_available()
      else
        @mark_unavailable()
    # going back in time; might need to unset date taken
    else
      if @completed
        if new_year_term.value() > @year_term_taken.value()
          @mark_completed(@year_term_taken)
        else if new_year_term.value() == @year_term_taken.value()
          @mark_enrolling(@year_term_taken)
        else if @available(new_year_term)
          @mark_available()
        else
          @mark_unavailable()
      # not completed, but it was marked enrolling? Then it isn't taken or
      # enrolled. Pretend it it never happened
      else if @available(new_year_term)
        @mark_available()
      else
        @mark_unavailable()

    
  add_coreq: (new_coreq) ->
    @coreqs.push(new_coreq)    

  add_prereq: (new_prereq) ->
    @prereqs.push(new_prereq)

class YearTerm
  constructor: (@year, @term) ->

  value: ->
    res = @year * 10
    if @term == 'fall'
      res += 5

    res
    
# combine course data with the course class to make useful objects
MATH_112 = new Course(course_data.MATH_112)
MATH_114 = new Course(course_data.MATH_114)
MATH_215 = new Course(course_data.MATH_215)
MATH_216 = new Course(course_data.MATH_216)
MATH_312 = new Course(course_data.MATH_312)
PHYS_186 = new Course(course_data.PHYS_186)
PHYS_231 = new Course(course_data.PHYS_231)
PHYS_232 = new Course(course_data.PHYS_232)
PHYS_240 = new Course(course_data.PHYS_240)
PHYS_255 = new Course(course_data.PHYS_255)
PHYS_332 = new Course(course_data.PHYS_332)
PHYS_333 = new Course(course_data.PHYS_333)
PHYS_340 = new Course(course_data.PHYS_340)
PHYS_350 = new Course(course_data.PHYS_350)
PHYS_356 = new Course(course_data.PHYS_356)
PHYS_360 = new Course(course_data.PHYS_360)
PHYS_361 = new Course(course_data.PHYS_361)
PHYS_362 = new Course(course_data.PHYS_362)
PHYS_363 = new Course(course_data.PHYS_363)
PHYS_365 = new Course(course_data.PHYS_365)
PHYS_367 = new Course(course_data.PHYS_367)
PHYS_375 = new Course(course_data.PHYS_375)
PHYS_430 = new Course(course_data.PHYS_430)
PHYS_445 = new Course(course_data.PHYS_445)
PHYS_465 = new Course(course_data.PHYS_465)
PHYS_486 = new Course(course_data.PHYS_486)



courses = [
  MATH_112, MATH_114, MATH_215, MATH_216, MATH_312,
  PHYS_186, PHYS_231, PHYS_232, PHYS_240, PHYS_255, PHYS_332, PHYS_333,
  PHYS_340, PHYS_350, PHYS_356, PHYS_360, PHYS_361, PHYS_362, PHYS_363,
  PHYS_365, PHYS_367, PHYS_375, PHYS_430, PHYS_445, PHYS_465, PHYS_486
]

# firm up requirements so they work properly
for course in courses
  course.update_requirements(courses)

today = new Date()
current_year = today.getFullYear()
current_month = today.getMonth()
first_term = 'fall'
second_term = 'spring'

year_terms = [
  new YearTerm(current_year, 'spring'),
  new YearTerm(current_year, 'fall'),
  new YearTerm(current_year + 1, 'spring'),
  new YearTerm(current_year + 1, 'fall'),
  new YearTerm(current_year + 2, 'spring'),
  new YearTerm(current_year + 2, 'fall'),
  new YearTerm(current_year + 3, 'spring'),
  new YearTerm(current_year + 3, 'fall'),
  new YearTerm(current_year + 4, 'spring'),
  new YearTerm(current_year + 4, 'fall'),
  new YearTerm(current_year + 5, 'spring'),
  new YearTerm(current_year + 5, 'fall'),
]

if current_month < 5
  year_terms = year_terms[0...11]
else
  year_terms = year_terms[1..11]

wizard =

  year_term: year_terms[0]

  course_groups: [
    {
      title: 'Introductory and Prerequisite Courses'
      courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, PHYS_231, PHYS_232, PHYS_240]
    },
    {
      title: 'Intermediate Courses'
      courses: [MATH_312, PHYS_255, PHYS_332, PHYS_333, PHYS_340, PHYS_350, PHYS_361, PHYS_365, PHYS_367]
    },
    {
      title: 'Advanced Courses'
      courses: [PHYS_356, PHYS_360, PHYS_375, PHYS_430, PHYS_445, PHYS_465, PHYS_486]
    }

  ]

  add_group: (new_group) ->
    to_add = "<hr class='my-5'>\n"
    to_add += "<div class='row'><div class='col'>\n"
    to_add += "  <h2>#{new_group.title}</h2>\n"
    to_add += "</div></div>\n"
    to_add += "<div class='row'>\n"
    for course in new_group.courses
      to_add += "  <div class='col-12 col-md-6 col-lg-4 col-xl-3 mb-3'>\n"
      to_add += "    #{course.html_card}"
      to_add += "  </div>\n"
    to_add += "</div>\n"
    $('#body').append(to_add)

  get_course: (designation) ->
    field = designation.split(' ')[0]
    number = Number(designation.split(' ')[1])
    for course in courses
      if course.field == field and course.number == number
        return course

  refresh: (old_year_term) ->
    for course in courses
      course.refresh(old_year_term, wizard.year_term)

  setup: ->
    # set up year-term selectors
    for i in [0...11]
      year = year_terms[i].year
      term = year_terms[i].term
      $('#year-term-selector a#year-term-' + i.toString() + 'a').text(term.replace(/^\w/, (c) => c.toUpperCase()) + ' ' + year)


    $('ul#year-term-selector a').click( (event) ->
      event.preventDefault()
      old_year_term = wizard.year_term
      position = Number($(this).data('position'))
      wizard.year_term = year_terms[position]
      $('ul#year-term-selector li').removeClass('active')
      $('ul#year-term-selector li#year-term-' + position.toString()).addClass('active')
      wizard.refresh(old_year_term)
    )    

    for group in wizard.course_groups
      wizard.add_group(group)

    # activate switch listeners
    $('input.completed').click( ->
      wizard.get_course(this.id.split('-')[0..1].join(' ')).toggle_completed()
      wizard.refresh(wizard.year_term)
    )
    $('input.enrolling').click( ->
      wizard.get_course(this.id.split('-')[0..1].join(' ')).toggle_enrolling()
      wizard.refresh(wizard.year_term)
    )

    # activate modal description listeners
    $('button.description').click( ->
      course = wizard.get_course(this.id.split('-')[0..1].join(' '))
      course.update_modal(wizard.year_term)
      $('#course-info').modal()
      $('#modal-enrolling').click( (event) ->
        event.preventDefault
        # leverage the fact that the title has the course name in it, with a
        # colon right after it. Janky, but it works for now!
        course = wizard.get_course($('#course-info-label').text().split(':')[0])
        course.enrolling = true
        course.completed = false
        course.year_term_taken = false
        wizard.refresh(wizard.year_term)
        $('#course-info').modal('hide')
      )
      $('#modal-completed').click( (event) ->
        event.preventDefault
        # leverage the fact that the title has the course name in it, with a
        # colon right after it. Janky, but it works for now!
        course = wizard.get_course($('#course-info-label').text().split(':')[0])
        course.enrolling = false
        course.completed = true
        wizard.refresh(wizard.year_term)
        $('#course-info').modal('hide')
      )
    )

    # set up initial availability
    wizard.refresh(wizard.year_term)
      
$( document ).ready( ->
  wizard.setup()
)
