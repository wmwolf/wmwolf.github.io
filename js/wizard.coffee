# to add a course:
# - add entry to course_data object
# - instantiate Course instance from entry in course_data object
# - add course to courses array
# - add course to any course plan's requirements and associated groups

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

  MATH_345:
    field: 'MATH'
    number: 345
    name: 'Introduction to Probability and Mathematical Statistics'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "Counting techniques, discrete and continuous random variables, probability distributions, sampling distributions, estimation, hypothesis testing, linear regression, correlation, nonparametric statistics. Students who desire more extensive probability and statistics should take Math 346/Math 546, Math 347/Math 547."
    le: []
    requirements:
      coreqs: ['MATH 215']
    years_offered: 'all'
    terms_offered: 'fall'

  CHEM_115:
    field: 'CHEM'
    number: 115
    name: 'Chemical Principles'
    lecture_hours: 3
    lab_hours: 6
    credits: 6
    description: "Principles of chemistry, including chemical properties and the periodic table, atomic structure, chemical bonding, equilibria, thermodynamics, acid-base reactions, oxidation-reduction reactions and complexation reactions."
    le: ['K1', 'K1L']
    requirements:
      exclude: ['CHEM 105', 'CHEM 106', 'CHEM 109']
    years_offered: 'all'
    terms_offered: 'fall'

  CHEM_105:
    field: 'CHEM'
    number: 105
    name: 'General Chemistry I Lecture'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Principles of chemistry, including atomic structure, physical and periodic properties, structure and bonding, reactions, thermochemistry, and stoichiometry."
    le: []
    requirements:
      exclude: ['CHEM 115']
    years_offered: 'all'
    terms_offered: 'all'

  CHEM_106:
    field: 'CHEM'
    number: 106
    name: 'General Chemistry I Laboratory'
    lecture_hours: 1
    lab_hours: 2
    credits: 2
    description: "A general chemistry lab/discussion experience. Gases, reactions, stoichiometry, solution chemistry, thermochem. Data collection, management, and interpretation."
    le: ['K1', 'K1L']
    requirements:
      coreqs: ['CHEM 105']
      exclude: ['CHEM 115']
    years_offered: 'all'
    terms_offered: 'all'

  CHEM_109:
    field: 'CHEM'
    number: 109
    name: 'General Chemistry II with Lab'
    lecture_hours: 3
    lab_hours: 3
    credits: 4
    description: "Solution properties and intermolecular forces; equilibrium, thermodynamic and kinetic aspects of chemical reactions; acid-base, precipitation, and redox reactions."
    le: []
    requirements:
      prereqs: ['CHEM 104', 'CHEM 105']
      exclude: ['CHEM 115']
    years_offered: 'all'
    terms_offered: 'all'

  MSE_120:
    field: 'MSE'
    number: 120
    name: 'Introduction to Engineering'
    lecture_hours: 1
    lab_hours: 2
    credits: 2
    description: "A comprehensive study of the engineering design process. Discussion of engineering disciplines with comparisons. The laboratory portion of the course includes design projects from various engineering disciplines."
    le: ['S3']
    requirements: null
    years_offered: 'all'
    terms_offered: 'all'

  MSE_221:
    field: 'MSE'
    number: 221
    name: 'Living in a Materials World'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Processing and structure’s impact on materials properties and performance. Societal benefits of sustainable, biomimetic, or responsible materials selection."
    le: []
    requirements:
      corez: ['MATH 114']
    years_offered: 'all'
    terms_offered: 'spring'

  MSE_315:
    field: 'MSE'
    number: 315
    name: 'Materials Characterization'
    lecture_hours: 2
    lab_hours: 4
    credits: 4
    description: "A survey of commonly used materials characterization methods (XPS, SEM, AFM, XRD, XRF), including their theory of operation and hands-on experience. Includes a discussion of the measurement process and instrumental analysis of samples."
    le: ['S3']
    requirements:
      prereqs: ['PHYS 231']
      combo: 
        min: 1
        options: ['CHEM 105', 'CHEM 115']
    years_offered: 'all'
    terms_offered: 'all'

  MSE_350:
    field: 'MSE'
    number: 350
    name: 'Thermodynamics of Materials'
    lecture_hours: 3
    lab_hours: 2
    credits: 4
    description: "Survey of the laws of thermodynamics and their application in Materials Science including phase equilibria. Mathematical skills relevant to engineering applications are discussed in the lab section."
    le: []
    requirements:
      prereqs: ['MSE 221', 'MATH 215']
      coreqs: ['PHYS 232']
      combo: 
        min: 1
        options: ['CHEM 109', 'CHEM 115']
    years_offered: 'all'
    terms_offered: 'fall'

  MSE_357:
    field: 'MSE'
    number: 357
    name: 'Phase Transformation & Kinetics'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Phase transformations are explored with emphasis on microstructure development, the impact of diffusion, and nucleation/growth mechanisms."
    le: []
    requirements:
      prereqs: ['MSE 221', 'MATH 215']
      combo: 
        min: 1
        options: ['CHEM 109', 'CHEM 115']
    years_offered: 'all'
    terms_offered: 'fall'

  MSE_372:
    field: 'MSE'
    number: 372
    name: 'Transport Phenomena'
    lecture_hours: 3
    lab_hours: 0
    credits: 3
    description: "Principles of momentum, heat, and mass transport. Applications of appropriate differential equations and boundary conditions to solve problems in materials processing."
    le: []
    requirements:
      prereqs: ['MATH 312']
    years_offered: 'all'
    terms_offered: 'spring'

  MSE_374:
    field: 'MSE'
    number: 374
    name: 'Electrical, Optical and Magnetic Properties of Materials'
    lecture_hours: 4
    lab_hours: 0
    credits: 4
    description: "A description of the behaviors of crystalline solids. Topics include crystallography, diffraction, and the electrical, optical and magnetic properties of materials. Semiconducting materials and devices will also be discussed."
    le: []
    requirements: 
      prereqs: ['PHYS 332']
    years_offered: 'all'
    terms_offered: 'fall'

  MSE_451:
    field: 'MSE'
    number: 451
    name: 'Computational Materials Science'
    lecture_hours: 2
    lab_hours: 3
    credits: 3
    description: "Theory and application of computational methods to model, understand and predict the behavior of materials. Labs provide hands-on experience in solving real materials problems using computational approaches. Note: can also take after CHEM 434, which is not part of this databse."
    le: []
    requirements:
      combo: 
        min: 1
        options: ['PHYS 333', 'MSE 350', 'CHEM 434']
    years_offered: 'all'
    terms_offered: 'spring'

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
    name: 'Thermal Physics'
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
    le: ['S3']
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
    @context_classes = ['default', 'primary', 'secondary', 'success', 'warning', 'danger', 'thick']
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
    @html_card += "      <div class='col-5'>\n"
    @html_card += "        <button type='button' class='btn btn-sm description' id='#{@modal_id}'>Details</button>\n"
    @html_card += "     </div>\n"
    @html_card += "      <div class='col-7 px-1'>\n"
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

  toString: ->
    "#{@field} #{@number}"

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
    if @exclude_designations.length > 0
      $('#course-description').append("<p><span class='font-italic'>No credit if taken with/after:</span> #{@exclude_designations.join(', ')}</p>")
    if @combo_option_designations.length > 0
      $('#course-description').append("<p><span class='font-italic'>Must have taken at least #{@combo_option_min} of:</span> #{@combo_option_designations.join(', ')}</p>")

    availability = 'Offered '
    if @terms_offered == 'all'
      availability += 'every term.'
    else if @years_offered == 'all'
      availability += "in the <span class='font-weight-bold'>#{@terms_offered} term</span> every year."
    else
      availability += "in the <span class='font-weight-bold'>#{@terms_offered} term of #{@years_offered} years</span>."
    $('#course-description').append("<p>#{availability}</p>")
    $('#modal-enrolling').prop('disabled', !@available(year_term) || @completed)


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

  # find courses that have this course as a direct dependence
  downstream: (courses) ->
    res = []
    for course in courses
      if course.prereqs.includes(this) || course.coreqs.includes(this)
        res.push(course)
    res

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

    # handle courses that exclude other courses (ex. 356 & 365)  
    for course in @exclusions
      res = res && !(course.completed || course.enrolling)

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

  mark_available: (degree_plan) ->
    @completed = false
    @year_term_taken = false
    @enrolling = false
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
    $(@card_sel).addClass('border-warning')
    $(@header_sel).addClass('bg-warning text-white')
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', false)
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', false)
    $(@modal_sel).addClass('btn-warning')

  mark_unavailable: (degree_plan) ->
    @completed = false
    @year_term_taken = false
    @enrolling = false
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
    $(@card_sel).addClass('border-secondary')
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', true)
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', false)
    $(@modal_sel).addClass('btn-secondary')

  mark_completed: (year_term, degree_plan) ->
    @completed = true
    @year_term_taken = year_term
    @enrolling = false
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
    $(@card_sel).addClass('border-success')
    $(@header_sel).addClass('bg-success text-white')
    $(@completed_sel).prop('checked', true)
    $(@enrolling_sel).prop('checked', false)
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', true)
    $(@modal_sel).addClass('btn-success')


    for course in @prereqs
      unless course.completed && course.year_term_taken
        course.mark_completed(year_term, degree_plan)

    for course in @coreqs
      unless course.completed && course.year_term_taken
        course.mark_completed(year_term, degree_plan)

    # make sure that upstream courses know about the changes. You'd think
    # that refresh would handle this, but it seems it doesn't, at least in the
    # case where marking something complete would make its prerequsities be
    # complete, but then courses downstream from those prerequisites would NOT
    # get marked complete. This appears to fix the problem.
    for course in @downstream(courses)
      course.refresh(year_term, year_term, degree_plan)

  mark_enrolling: (year_term, degree_plan) ->
    @completed = false
    @year_term_taken = year_term
    @enrolling = true
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
    $(@card_sel).addClass('border-primary')
    $(@header_sel).addClass('bg-primary text-white')
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', true)
    $(@completed_sel).prop('disabled', true)
    $(@enrolling_sel).prop('disabled', false)
    $(@modal_sel).addClass('btn-primary')
    
  refresh: (old_year_term, new_year_term, degree_plan) ->

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
        @mark_available(degree_plan)
      else
        @mark_unavailable(degree_plan)
  
    # staying in the same year-term (changed status of one course)
    else if new_year_term.value() == old_year_term.value()
      if @completed
        if !@year_term_taken
          # probably just marked completed; pretend it was taken the term
          # before it was marked completed
          @mark_completed(old_year_term.prev())
        else
          @mark_completed(@year_term_taken)
      else if @enrolling
        @mark_enrolling(new_year_term, degree_plan)
      else if @available(new_year_term)
        @mark_available(degree_plan)
      else
        @mark_unavailable(degree_plan)
    # going back in time; might need to unset date taken
    else
      if @completed
        if new_year_term.value() > @year_term_taken.value()
          @mark_completed(@year_term_taken)
        else if new_year_term.value() == @year_term_taken.value()
          @mark_enrolling(@year_term_taken, degree_plan)
        else if @available(new_year_term)
          @mark_available(degree_plan)
        else
          @mark_unavailable(degree_plan)
      # not completed, but it was marked enrolling? Then it isn't taken or
      # enrolled. Pretend it it never happened
      else if @available(new_year_term)
        @mark_available(degree_plan)
      else
        @mark_unavailable(degree_plan)


class DegreePlan
  constructor: (@degree_plan_info) ->
    @name = @degree_plan_info.name
    @credits_needed = @degree_plan_info.credits_needed
    @counted_classes = 
      requirements: []
      choices: []
    @uncounted_classes =
      requirements: []
      choices: []
    @extra_electives = []

    @course_groups = @degree_plan_info.course_groups

    # track class objects in the various requirements, rather than just class
    # designations
    unless @degree_plan_info.counted == undefined
      unless @degree_plan_info.counted.requirements == undefined
        for class_name in @degree_plan_info.counted.requirements
          @counted_classes.requirements.push(get_course(class_name))
      unless @degree_plan_info.counted.choices == undefined
        for combo in @degree_plan_info.counted.choices
          new_combo = []
          for sequence in combo
            new_sequence = []
            for class_name in sequence
              new_sequence.push(get_course(class_name))
            new_combo.push(new_sequence)
          @counted_classes.choices.push(new_combo)

    unless @degree_plan_info.uncounted == undefined
      unless @degree_plan_info.uncounted.requirements == undefined
        for class_name in @degree_plan_info.uncounted.requirements
          @uncounted_classes.requirements.push(get_course(class_name))
      unless @degree_plan_info.uncounted.choices == undefined
        for combo in @degree_plan_info.uncounted.choices
          new_combo = []
          for sequence in combo
            new_sequence = []
            for class_name in sequence
              new_sequence.push(get_course(class_name))
            new_combo.push(new_sequence)
          @uncounted_classes.choices.push(new_combo)

    unless @degree_plan_info.extra_electives == undefined
      for class_name in @degree_plan_info.extra_electives
        @extra_electives.push(get_course(class_name))

  # determine if a course sequence (part of a combination of possible options)
  # is "complete". It's considered complete when all courses are already
  # completed OR ENROLLED (which may be counterintuitive, but this lets us
  # mark other sequences as not required anymore)
  sequence_completed: (sequence) ->
    res = true
    for course in sequence
      res = res && (course.completed || course.enrolling)
    res

  # determine if a course is "required". We interpret this to be if the class
  # is simply a required course, or it is part of a sequence of courses
  # comprising one possibility in a combination option. Note that partially-
  # completed sequences will still courses in OTHER sequences in the same combo
  # to appear as required.
  required: (course) ->
    # first check required courses (simple)
    if @counted_classes.requirements.includes(course)
      return true
    else if @uncounted_classes.requirements.includes(course)
      return true
    # bail if it doesn't appear in any choices lists
    else if !(@counted_classes.choices.flat(4).includes(course) || @uncounted_classes.choices.flat(4).includes(course))
      return false
    # Crap. It's a class in a series of choices, so we need to figure out
    # if another option has already been completed.
    else if @counted_classes.choices.flat(4).includes(course)
      # each "combo" is really a collection of course sequences (each of which
      # may only contain one course). The points is there could be a
      # requirement to take one of classes A, B, and C, AND there could be
      # an additional requirement that someone take both D and E, or just F.
      # In this example, [A], [B], and [C] represent a combination of
      # sequences, each of length 1.
      for combo in @counted_classes.choices
        # don't consider combination of sequences if course doesn't appear
        unless combo.flat(3).includes(course)
          continue
        # bail out if any one sequence is completed
        for sequence in combo
          # skip the sequence if the class appears in it (it might be complete,
          # but our convention is that completed courses can still be
          # "required")
          if sequence.flat(2).includes(course)
            continue
          if @sequence_completed(sequence)
            return false
      return true
    else if @uncounted_classes.choices.flat(4).includes(course)
      for combo in @uncounted_classes.choices
        # don't consider combination of sequences if course doesn't appear
        unless combo.flat(3).includes(course)
          continue
        # bail out if any one sequence is completed
        for sequence in combo
          # skip the sequence if the class appears in it (it might be complete,
          # but our convention is that completed courses can still be
          # "required")
          unless sequence.flat(2).includes(course)
            continue
          if @sequence_completed(sequence)
            return false
      return true

  # compute how many credits count towards the major requirement of 36 hours
  credit_count: ->
    credit_count = 0
    for course in courses
      if course.completed || course.enrolling
        # is course explicitly a requirement, choice, or explicit elective?
        if @counted_classes.requirements.includes(course) || @counted_classes.choices.flat(3).includes(course) || @extra_electives.includes(course)
          credit_count += course.credits
        # is course an implicit elective (PHYS class numbered over 325)
        else if course.field == 'PHYS' && course.number > 325
          credit_count += course.credits
    credit_count


class YearTerm
  constructor: (@year, @term) ->

  value: ->
    res = @year * 10
    if @term == 'fall'
      res += 5

    res

  prev: ->
    new_term = 'fall'
    new_year = @year
    if @term == 'fall'
      new_term = 'spring'
    else
      new_year -= 1
    new YearTerm(new_year, new_term)

  next: ->
    new_term = 'fall'
    new_year = @year
    if @term == 'fall'
      new_term = 'spring'
      new_year += 1
    new YearTerm(new_year, new_term)

  toString: ->
    "#{@term.replace(/^\w/, (c) => c.toUpperCase())} #{@year}"
    
# combine course data with the course class to make useful objects
MATH_112 = new Course(course_data.MATH_112)
MATH_114 = new Course(course_data.MATH_114)
MATH_215 = new Course(course_data.MATH_215)
MATH_216 = new Course(course_data.MATH_216)
MATH_312 = new Course(course_data.MATH_312)
MATH_345 = new Course(course_data.MATH_345)
CHEM_105 = new Course(course_data.CHEM_105)
CHEM_106 = new Course(course_data.CHEM_106)
CHEM_109 = new Course(course_data.CHEM_109)
CHEM_115 = new Course(course_data.CHEM_115)
MSE_120  = new Course(course_data.MSE_120)
MSE_221  = new Course(course_data.MSE_221)
MSE_350  = new Course(course_data.MSE_350)
MSE_374  = new Course(course_data.MSE_374)
MSE_315  = new Course(course_data.MSE_315)
MSE_357  = new Course(course_data.MSE_357)
MSE_372  = new Course(course_data.MSE_372)
MSE_451  = new Course(course_data.MSE_451)
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
  MATH_112, MATH_114, MATH_215, MATH_216, MATH_312, MATH_345,
  CHEM_105, CHEM_106, CHEM_109, CHEM_115,
  MSE_120, MSE_315, MSE_221, MSE_350, MSE_357, MSE_372, MSE_374, MSE_451
  PHYS_186, PHYS_231, PHYS_232, PHYS_240, PHYS_255, PHYS_332, PHYS_333,
  PHYS_340, PHYS_350, PHYS_356, PHYS_360, PHYS_361, PHYS_362, PHYS_363,
  PHYS_365, PHYS_367, PHYS_375, PHYS_430, PHYS_445, PHYS_465, PHYS_486
]

# firm up requirements so they work properly
for course in courses
  course.update_requirements(courses)

degree_plan_data = [
  {
    name: 'Liberal Arts'
    credits_needed: 36
    counted:
      requirements: ['PHYS 186', 'PHYS 231', 'PHYS 232', 'PHYS 332', 'PHYS 333',
      'PHYS 350', 'PHYS 365', 'PHYS 486']
      choices: [[['PHYS 340'], ['PHYS 360']]]
    uncounted:
      requirements: ['MATH 312', 'PHYS 240']
      choices: []
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, PHYS_231, PHYS_232, PHYS_240]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, PHYS_332, PHYS_333, PHYS_340, PHYS_350, PHYS_365]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_360, PHYS_486]
      },
      {
        title: 'Electives'
        courses: [PHYS_361, PHYS_362, PHYS_363, PHYS_367, PHYS_375, PHYS_430,
        PHYS_445, PHYS_465, MSE_315, MSE_357, MSE_372, MSE_374, MSE_451]
      },
      {
        title: 'Elective Support (uncounted towards major)'
        courses: [CHEM_105, CHEM_106, CHEM_109, CHEM_115, MSE_221, MSE_350]
      }

    ]
  },
  {
    name: 'Applied'
    credits_needed: 36
    counted:
      requirements: ['PHYS 231', 'PHYS 232', 'PHYS 332',
      'PHYS 340', 'PHYS 350', 'PHYS 360', 'PHYS 430', 'PHYS 486']
      choices: [[['PHYS 186'], ['MSE 120']], [['PHYS 255', 'PHYS 356'], ['PHYS 365'], ['PHYS 375']]]
    uncounted:
      requirements: ['MATH 312', 'MATH 345', 'PHYS 240']
      choices: [[['CHEM 115'], ['CHEM 105', 'CHEM 106', 'CHEM 109']]]
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, MSE_120,
        PHYS_231, PHYS_232, PHYS_240, CHEM_105, CHEM_106, CHEM_109, CHEM_115]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, MATH_345, PHYS_255, PHYS_332, PHYS_333, PHYS_340, PHYS_350,
        PHYS_361, PHYS_365]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_356, PHYS_360, PHYS_375, PHYS_430, PHYS_486]
      },
      {
        title: 'Electives'
        courses: [PHYS_333, PHYS_367, PHYS_445, PHYS_465, MSE_315, MSE_357, MSE_372, MSE_374, MSE_451]
      },
      {
        title: 'Elective Support (uncounted towards major)'
        courses: [MSE_221, MSE_350]
      }
    ]
  },
  {
    name: 'Dual Degree'
    credits_needed: 36
    counted:
      requirements: ['MSE 120', 'PHYS 231', 'PHYS 232', 'PHYS 332',
      'PHYS 340', 'PHYS 350']
      choices: [[['PHYS 255', 'PHYS 356'], ['PHYS 365']]]
    uncounted:
      requirements: ['MATH 312', 'PHYS 240']
      choices: [[['CHEM 115'], ['CHEM 105', 'CHEM 106', 'CHEM 109']]]
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, MSE_120, PHYS_231, PHYS_232, PHYS_240]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, PHYS_255, PHYS_332, PHYS_340, PHYS_350, PHYS_365]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_356, PHYS_360]
      },
      {
        title: 'Electives'
        courses: [PHYS_333, PHYS_360, PHYS_361, PHYS_362, PHYS_363, PHYS_367,
        PHYS_375, PHYS_430, PHYS_445, PHYS_465, MSE_374, MSE_357, MSE_372, MSE_451]
      }
      {
        title: 'Elective Support (uncounted towards major)'
        courses: [CHEM_105, CHEM_106, CHEM_109, CHEM_115, MSE_221, MSE_350]
      }
    ]
  }
]

get_course = (designation) ->
  field = designation.split(' ')[0]
  number = Number(designation.split(' ')[1])
  for course in courses
    if course.field == field and course.number == number
      return course

# set up degree plans
degree_plans = (degree_plan_data.map (dpd) -> new DegreePlan(dpd))

get_degree_plan = (plan_name) ->
  for dp in degree_plans
    if dp.name == plan_name
      return dp

# compute counted credits towards the degree


    
  


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
  new YearTerm(current_year + 6, 'spring')
]

if current_month < 5
  year_terms = year_terms[0..11]
else
  year_terms = year_terms[1..12]

wizard =

  year_term: year_terms[0]
  degree_plan: degree_plans[0]

  course_groups: [
    {
      title: 'Introductory and Prerequisite Courses'
      courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, PHYS_231, PHYS_232, PHYS_240]
    },
    {
      title: 'Intermediate Courses'
      courses: [MATH_312, PHYS_255, PHYS_332, PHYS_333, PHYS_340, PHYS_350, PHYS_361, PHYS_365]
    },
    {
      title: 'Advanced Courses'
      courses: [PHYS_356, PHYS_360, PHYS_367, PHYS_375, PHYS_430, PHYS_445, PHYS_465, PHYS_486]
    },
    {
      title: 'Other Courses'
      courses: [CHEM_105, CHEM_106, CHEM_109, CHEM_115, MATH_345]
    }
  ]

  clear_groups: ->
    $('#body').html('')

  add_group: (new_group) ->
    to_add = "<hr class='my-4'>\n"
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

  refresh: (old_year_term) ->
    for course in courses
      course.refresh(old_year_term, wizard.year_term, wizard.degree_plan)

    # update credit count display
    credit_count = wizard.degree_plan.credit_count()
    $('#credit_count').html(credit_count)
    if credit_count >= wizard.degree_plan.credits_needed
      $('#credit-status').removeClass('text-danger').addClass('text-success')
    else
      $('#credit-status').addClass('text-danger').removeClass('text-success')

    # update the course plan
    wizard.build_course_plan()

  set_degree_plan: (new_degree_plan) ->
    wizard.degree_plan = new_degree_plan
    wizard.clear_groups()
    for group in wizard.degree_plan.course_groups
      wizard.add_group(group)
    wizard.setup_course_listeners()

  build_course_plan: ->
    $('#course-plan').html('')
    table_html = ""
    for year_term in year_terms
      this_year_term_courses = []
      for course in courses
        if course.completed || course.enrolling
          if course.year_term_taken.value() == year_term.value()
            this_year_term_courses.push(course)
      if this_year_term_courses.length > 0
        table_html += "  <thead class='thead-dark'>\n"
        table_html += "    <tr><th scope='col' colspan=3 class='text-center'>#{year_term}</th></tr>\n"
        table_html += "  </thead>\n"
        table_html += "  <thead class='thead-light'>\n"
        table_html += "    <tr>\n"
        table_html += "      <th scope='col'>Course #</th>\n"
        table_html += "      <th scope='col'>Course Name</th>\n"
        table_html += "      <th scope='col'>Credits</th>\n"
        table_html += "    </tr>\n"
        table_html += "  </thead>\n"
        table_html += "  <tbody>\n"
        for course in this_year_term_courses
          table_html += "    <tr>\n"
          table_html += "      <td>#{course.field} #{course.number}</td>\n"
          table_html += "      <td>#{course.name}</td>\n"
          table_html += "      <td>#{course.credits}</td>\n"
          table_html += "    </tr>\n"
        table_html += "  </tbody>\n"
    unless table_html == ""
      table_html = "<table class='table'>\n#{table_html}</table>\n"
      $('#course-plan').html("<h1 class='my-4'>Course Plan</h1>\n#{table_html}")

  setup_course_listeners: ->
    # activate switch listeners
    $('input.completed').click( ->
      this_course = get_course(this.id.split('-')[0..1].join(' '))
      this_course.toggle_completed()
      wizard.refresh(wizard.year_term)
    )
    $('input.enrolling').click( ->
      get_course(this.id.split('-')[0..1].join(' ')).toggle_enrolling()
      wizard.refresh(wizard.year_term)
    )

    # activate modal description listeners
    $('button.description').click( ->
      course = get_course(this.id.split('-')[0..1].join(' '))
      course.update_modal(wizard.year_term)
      $('#course-info').modal()

      $('#modal-enrolling').click( (event) ->
        event.preventDefault
        # leverage the fact that the title has the course name in it, with a
        # colon right after it. Janky, but it works for now!
        course = get_course($('#course-info-label').text().split(':')[0])
        course.enrolling = true
        course.completed = false
        # for i in [0...5]
        wizard.refresh(wizard.year_term)
        $('#course-info').modal('hide')
      )
      $('#modal-completed').click( (event) ->
        event.preventDefault
        # leverage the fact that the title has the course name in it, with a
        # colon right after it. Janky, but it works for now!
        course = get_course($('#course-info-label').text().split(':')[0])
        course.enrolling = false
        course.completed = true
        wizard.refresh(wizard.year_term)
        $('#course-info').modal('hide')
      )
    )



  setup: ->
    ### Year Term Menu and Next Button ###
    first_year = year_terms[0].year
    first_term = year_terms[0].term.replace(/^\w/, (c) => c.toUpperCase())

    # populate dropdown menu
    $('#year-term-dropdown').text("#{first_term} #{first_year}")
    for i in [0..11]
      year = year_terms[i].year
      term = year_terms[i].term.replace(/^\w/, (c) => c.toUpperCase())
      $("#year-term-menu>a[data-position='#{i}']").text("#{term} #{year}")

    # Set up listeners for year-term dropdown menu
    $('#year-term-menu>a').click( (event) ->
      event.preventDefault()

      # update year-term, but hold on to old one so we can refresh, which 
      # requires knowing both the old and new term
      old_year_term = wizard.year_term
      position = Number($(this).data('position'))
      wizard.year_term = year_terms[position]

      # move active status to new choice
      $('#year-term-menu>a').removeClass('active')
      $("#year-term-menu>a[data-position='#{position}']").addClass('active')

      # update button text
      new_term = wizard.year_term.term.replace(/^\w/, (c) => c.toUpperCase())
      $('#year-term-dropdown').text("#{new_term} #{wizard.year_term.year}")
      wizard.refresh(old_year_term)

      # conditionally disable next button text
      if wizard.year_term.value() == year_terms[year_terms.length - 1].value()
        $('#next-term').prop('disabled', true)
    )

    # get next term button working
    $('#next-term').click( (event) ->
      event.preventDefault()

      # update year-term, but hold on to old one so we can refresh, which 
      # requires knowing both the old and new term
      old_year_term = wizard.year_term
      wizard.year_term = wizard.year_term.next()
      new_term = wizard.year_term.term.replace(/^\w/, (c) => c.toUpperCase())

      # move active status to new choice
      $('#year-term-menu>a').removeClass('active')
      $("#year-term-menu>a:contains('#{new_term} #{wizard.year_term.year}')").addClass('active')      

      # update button text
      new_term = wizard.year_term.term.replace(/^\w/, (c) => c.toUpperCase())
      $('#year-term-dropdown').text("#{new_term} #{wizard.year_term.year}")
      wizard.refresh(old_year_term)

      # conditionally disable next button
      if wizard.year_term.value() == year_terms[year_terms.length - 1].value()
        $('#next-term').prop('disabled', true)
    )

    ### Degree Plan Dropdown ###

    # initialize degree plan dropdown button text
    $('#degree-plan-dropdown').text(wizard.degree_plan.name)

    # Populate degree plan dropdown
    for dp in degree_plans
      if dp == wizard.degree_plan
        $('#degree-plan-menu').append(
          "<a class='dropdown-item degree-plan-option active' href='#'>#{dp.name}</a>")
      else
        $('#degree-plan-menu').append(
          "<a class='dropdown-item degree-plan-option' href='#'>#{dp.name}</a>")

    # make degree plan dropdown actually switch degree plans
    $('#degree-plan-menu>a.degree-plan-option').click( (event)->
      event.preventDefault()
      self = this
      wizard.set_degree_plan(get_degree_plan(self.text))
      $('#degree-plan-menu>a.degree-plan-option').removeClass('active')
      $("#degree-plan-menu>a.degree-plan-option:contains(#{wizard.degree_plan.name})").addClass('active')
      $('#degree-plan-dropdown').html(wizard.degree_plan.name)

      wizard.refresh(wizard.year_term)
    )

    ### Setup Initial Degree Plan ###

    wizard.set_degree_plan(wizard.degree_plan)

    # set up initial availability
    wizard.refresh(wizard.year_term)
      
$( document ).ready( ->
  wizard.setup()
)
