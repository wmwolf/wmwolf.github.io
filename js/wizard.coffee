# to add a course:
# - add entry to course_data.json object
# - instantiate Course instance from entry in course_data object
# - add course to courses array
# - add course to any course plan's requirements and associated groups
#
# to deprecate a course:
# - set deprecated: true in the course_data.json entry
# - optionally set last_offered_year and last_offered_term
#
# to schedule availability:
# - set first_offered_year and first_offered_term for future courses
# - set last_offered_year and last_offered_term for courses being phased out

# Load course data from JSON file
courseDataJson = null

loadCourseData = ->
  $.ajax
    url: '/js/course_data.json'
    dataType: 'json'
    async: false
    success: (data) ->
      courseDataJson = data
    error: (xhr, status, error) ->
      console.error("Error loading course data: #{error}")
      
loadCourseData()

deprecated_synonyms = courseDataJson?.deprecated_synonyms || ['discontinued', 'deprecated', 'legacy', 'old']
course_data = courseDataJson?.course_data

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
    @deprecated = @course_info.deprecated || false
    @last_offered_year = @course_info.last_offered_year
    @last_offered_term = @course_info.last_offered_term
    @first_offered_year = @course_info.first_offered_year
    @first_offered_term = @course_info.first_offered_term

    # designations are strings, reguaar values hold actual courses
    # actual courses need to be set up later, since there's no guarantee 
    # the courses already exist, nor is there a way to get at them
    # 
    # prereqs: course must be taken BEFORE enrolling
    # coreqs: course must be taken BEFORE or WHILE enrolling
    # prereq_options: some number of these courses must be taken BEFORE enrolling
    # options: at least one of these courses must be taken BEFORE enrolling
    # exclude: cannot enroll if any of these courses have been completed
    @prereq_designations = []
    @coreq_designations = []
    @combo_option_designations = []
    @option_designations = []
    @exclude_designations = []

    @prereqs = []
    @coreqs = []
    @combo_options = []
    @combo_option_min = 0
    @options = []
    @exclusions = []

    unless @course_info.requirements == null
      unless @course_info.requirements.prereqs == undefined
        @prereq_designations = @course_info.requirements.prereqs

      unless @course_info.requirements.coreqs == undefined
        @coreq_designations = @course_info.requirements.coreqs

      unless @course_info.requirements.combo == undefined
        @combo_option_designations = @course_info.requirements.combo.options
        @combo_option_min = @course_info.requirements.combo.min
      
      unless @course_info.requirements.options == undefined
        @option_designations = @course_info.requirements.options

      unless @course_info.requirements.exclude == undefined
        @exclude_designations = @course_info.requirements.exclude

    @years_offered = @course_info.years_offered
    @terms_offered = @course_info.terms_offered

    # HTML helpers
    @context_classes = ['default', 'primary', 'secondary', 'success', 'warning', 'danger', 'thick']
    @all_border_classes = (@context_classes.map (cls) -> 'border-' + cls).join(' ')
    @all_bg_classes = (@context_classes.map (cls) -> 'bg-' + cls).join(' ')
    @all_btn_classes = (@context_classes.map (cls) -> 'btn-' + cls).join(' ')

    # Generate id suffix for distinguishing between similar courses
    # This makes deprecated/legacy versions have unique identifiers
    @id_suffix = @compute_id_suffix()
    
    # Generate all the IDs and selectors
    @setup_ids_and_selectors()

    # state variables
    @completed = false
    @enrolling = false
    @year_term_taken = false

    # Generate the HTML card
    @generate_html_card()
    
  # Compute a suffix to add to IDs for distinguishing different versions of courses
  compute_id_suffix: ->
    id_suffix = ""
    
    # Add a suffix for deprecated courses to distinguish them
    if @deprecated
      # For regular deprecated courses, just use "_legacy"
      id_suffix = "_legacy"
      
    # You could add more suffix rules here for other special cases
    
    return id_suffix

  # Set up all the IDs and selectors used for HTML elements
  setup_ids_and_selectors: ->
    @completed_id = "#{@field}-#{@number}#{@id_suffix}-completed"
    @enrolling_id = "#{@field}-#{@number}#{@id_suffix}-enrolling"
    @card_id = "#{@field}#{@number}#{@id_suffix}"
    @modal_id = "#{@field}-#{@number}#{@id_suffix}"

    @completed_sel = '#' + @completed_id
    @enrolling_sel = '#' + @enrolling_id
    @card_sel = '#' + @card_id
    @header_sel = @card_sel + '>h5.card-header'
    @modal_sel = '#' + @modal_id
  
  # Generate the HTML for the course card
  generate_html_card: ->
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
    # Update modal content
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

    # Update availability information
    availability = 'Offered '
    
    # Check for special cases first (deprecated or future courses)
    if @deprecated
      if @last_offered_year && @last_offered_term
        availability = "<span class='text-danger'>Discontinued. Last offered in the #{@last_offered_term} term of #{@last_offered_year}.</span>"
      else
        availability = "<span class='text-danger'>Discontinued. No longer offered.</span>"
    else if @first_offered_year? && @first_offered_term?
      # Format varies based on whether it's a new version or just a future course
      if @name.toLowerCase().includes('new version')
        availability = "<span class='text-success'>New version. First offered in the #{@first_offered_term} term of #{@first_offered_year}.</span>"
      else
        availability = "<span class='text-info'>Coming soon. First offered in the #{@first_offered_term} term of #{@first_offered_year}."
        
        # Add additional information about regular offering pattern
        if @years_offered == 'all'
          availability += " Will be offered in the #{@terms_offered} term every year thereafter.</span>"
        else
          availability += " Will be offered in the #{@terms_offered} term of #{@years_offered} years thereafter.</span>"
    # Regular offerings (not deprecated or future)
    else if @terms_offered == 'all'
      availability += 'every term.'
    else if @years_offered == 'all'
      availability += "in the <span class='font-weight-bold'>#{@terms_offered} term</span> every year."
    else
      availability += "in the <span class='font-weight-bold'>#{@terms_offered} term of #{@years_offered} years</span>."
    
    $('#course-description').append("<p>#{availability}</p>")
    
    # Update button states
    isAvailable = @available(year_term)
    $('#modal-enrolling').prop('disabled', !isAvailable || @completed)


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
    for designation in @option_designations
      for course in courses
        if "#{course.field} #{course.number}" == designation
          @options.push(course)
          
    # For exclusions, we need special handling to ensure all versions are properly excluded
    for designation in @exclude_designations
      matched = false
      
      # Check if this is a PHYS 332 exclusion
      if designation == "PHYS 332" || designation == "PHYS 332 legacy" || designation.includes("University Physics III")
        if @field == "PHYS" && @number == 332
          # When PHYS 332 is excluding PHYS 332 legacy or vice versa, 
          # we need to handle the special case
          if @deprecated 
            # This is PHYS 332 legacy, so exclude the non-legacy version
            for course in courses
              if course.field == "PHYS" && course.number == 332 && !course.deprecated
                @exclusions.push(course)
                matched = true
          else
            # This is normal PHYS 332, so exclude the legacy version
            for course in courses
              if course.field == "PHYS" && course.number == 332 && course.deprecated
                @exclusions.push(course)
                matched = true
      
      # Fall back to normal exclusion handling if not matched yet
      if !matched
        for course in courses
          basic_match = "#{course.field} #{course.number}" == designation
          name_match = course.name == designation || course.name.includes(designation)
          if basic_match || name_match
            @exclusions.push(course)
            matched = true

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
    
    # Helper function to compare terms (spring comes before fall in the same year)
    term_value = (y, t) ->
      value = y * 10
      value += if t == 'fall' then 5 else 0
      return value
    
    current_term_value = term_value(year, term)
    
    # Check if course is available during the given term
    # If the course is scheduled for the future, it's not available now
    if @first_offered_year? && @first_offered_term?
      first_offered_value = term_value(@first_offered_year, @first_offered_term)
      if current_term_value < first_offered_value
        return false
    
    # If the course is deprecated, check if we've passed its last offering
    if @deprecated && @last_offered_year? && @last_offered_term?
      last_offered_value = term_value(@last_offered_year, @last_offered_term)
      if current_term_value > last_offered_value
        return false
    
    # Check prerequisites, corequisites, etc.
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
    
    # handle options - at least one option must be completed
    if @options.length > 0
      option_completed = false
      for option in @options
        if option.completed
          option_completed = true
          break
      res = res && option_completed

    # handle courses that exclude other courses (ex. 356 & 365)  
    for course in @exclusions
      excluded_state = course.completed || course.enrolling
      res = res && !excluded_state

    # offered this year?
    res = res && ((@years_offered == 'all') || \
      ((@years_offered == 'even') && (year % 2 == 0)) || \
      ((@years_offered == 'odd') && (year % 2 == 1)) )
    # offered this term?
    res = res && ((@terms_offered == 'all') || @terms_offered == term)
    
    res

  clear_formatting: ->
    $(@card_sel).removeClass(@all_border_classes)
    $(@header_sel).removeClass(@all_bg_classes)
    $(@header_sel).removeClass('text-white font-weight-bold')
    $(@modal_sel).removeClass(@all_btn_classes)
    # Remove shadow effect
    $(@card_sel).css('box-shadow', '')
    # Also remove any badges
    $(@header_sel + " span.badge").remove()
    # $(@modal_sel).addClass('btn-secondary')
    
  update_badge: ->
    # Ensure there are no existing badges first
    $(@header_sel + " span.badge").remove()
    
    # Add the appropriate badge if needed
    if @deprecated && @last_offered_year? && @last_offered_term?
      $(@header_sel).append(" <span class='badge badge-danger'>Discontinued</span>")
    else if @first_offered_year? && @first_offered_term?
      $(@header_sel).append(" <span class='badge badge-info'>Coming #{@first_offered_term} #{@first_offered_year}</span>")

  mark_available: (degree_plan) ->
    @completed = false
    @year_term_taken = false
    @enrolling = false
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
        $(@header_sel).addClass('font-weight-bold')
        # Add shadow to required and available courses
        $(@card_sel).css('box-shadow', '0 6px 12px rgba(0,0,0,0.5)')
    $(@card_sel).addClass('border-warning')
    $(@header_sel).addClass('bg-warning text-white')
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', false)
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', false)
    $(@modal_sel).addClass('btn-warning')
    
    # Add visual indicator for future courses
    @update_badge()

  mark_unavailable: (degree_plan) ->
    @completed = false
    @year_term_taken = false
    @enrolling = false
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
        $(@header_sel).addClass('font-weight-bold')
    $(@card_sel).addClass('border-secondary')
    $(@completed_sel).prop('disabled', false)
    $(@enrolling_sel).prop('disabled', true)
    $(@completed_sel).prop('checked', false)
    $(@enrolling_sel).prop('checked', false)
    
    # Always add btn-secondary regardless of whether course is deprecated or future
    $(@modal_sel).addClass('btn-secondary')
    
    # Add visual indicator for deprecated or future courses
    @update_badge()

  mark_completed: (year_term, degree_plan) ->
    @completed = true
    @year_term_taken = year_term
    @enrolling = false
    @clear_formatting()
    if degree_plan
      if degree_plan.required(this)
        $(@card_sel).addClass('border-thick')
        $(@header_sel).addClass('font-weight-bold')
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
        $(@header_sel).addClass('font-weight-bold')
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
        @mark_completed(old_year_term, degree_plan)
        $(@enrolling_sel).prop('checked', @enrolling)
        $(@completed_sel).prop('checked', @completed)
      else if @completed
        if new_year_term.value() > @year_term_taken.value()
          @mark_completed(@year_term_taken, degree_plan)
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
          @mark_completed(old_year_term.prev(), degree_plan)
        else
          @mark_completed(@year_term_taken, degree_plan)
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
          @mark_completed(@year_term_taken, degree_plan)
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
        # bail out if any one sequence is completed; this class isn't needed
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
          if sequence.flat(2).includes(course)
            continue
          if @sequence_completed(sequence)
            return false
      return true

  # Check if all required courses are completed
  all_required_courses_complete: ->
    # Check all required courses
    for course in @counted_classes.requirements
      if !course.completed && !course.enrolling
        return false
    
    # Check all course choices (need at least one complete from each combo)
    for combo in @counted_classes.choices
      combo_satisfied = false
      
      # A combo is satisfied if at least one sequence is complete
      for sequence in combo
        if @sequence_completed(sequence)
          combo_satisfied = true
          break
          
      # If no sequence in this combo is complete, requirement is not met
      if !combo_satisfied
        return false
      
    # All requirements are met
    return true
    
  # compute how many credits count towards the degree requirement
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
PHYS_115 = new Course(course_data.PHYS_115)
PHYS_186 = new Course(course_data.PHYS_186)
# PHYS_205 = new Course(course_data.PHYS_205)
PHYS_226 = new Course(course_data.PHYS_226)
PHYS_229 = new Course(course_data.PHYS_229)
PHYS_231 = new Course(course_data.PHYS_231)
PHYS_232 = new Course(course_data.PHYS_232)
PHYS_240 = new Course(course_data.PHYS_240)
PHYS_255 = new Course(course_data.PHYS_255)
PHYS_308 = new Course(course_data.PHYS_308)
PHYS_315 = new Course(course_data.PHYS_315)
PHYS_332_legacy = new Course(course_data.PHYS_332_legacy)
PHYS_332 = new Course(course_data.PHYS_332)

PHYS_333 = new Course(course_data.PHYS_333)
PHYS_340 = new Course(course_data.PHYS_340)
PHYS_350 = new Course(course_data.PHYS_350)
PHYS_356 = new Course(course_data.PHYS_356)
PHYS_360 = new Course(course_data.PHYS_360)
# PHYS_361 = new Course(course_data.PHYS_361)
# PHYS_362 = new Course(course_data.PHYS_362)
# PHYS_363 = new Course(course_data.PHYS_363)
PHYS_365 = new Course(course_data.PHYS_365)
PHYS_367 = new Course(course_data.PHYS_367)
PHYS_375 = new Course(course_data.PHYS_375)
PHYS_415 = new Course(course_data.PHYS_415)
PHYS_430 = new Course(course_data.PHYS_430)
PHYS_445 = new Course(course_data.PHYS_445)
PHYS_465 = new Course(course_data.PHYS_465)
PHYS_486 = new Course(course_data.PHYS_486)

### IMPORTANT GLOBAL VARIABLE ###
# This lists all the coures objects and is used in several classes, which
# is terrible form, but hey, it works! Well, usually... The order is important.
# When cycling through the courses, its best if prerequisites come before
# the courses they depend on. So math courses should always go first, and then
# mostly courses can simply increase in number. However, care must be taken to
# ensure that some MSE courses are in the right place. For instance, MSE 451
# depends on PHYS 333, but if it comes before PHYS 333, completing PHYS 333
# will not immediately cause PHYS 451 to be marked as available because it is
# refreshed *before* PHYS 333 since it's earlier on the list.

# Fall 2022: Removed PHYS 205, 361, 362, and 363
# Spring 2025: Added (deprecated) PHYS_332_legacy, deprecated PHYS 333 and
# PHYS 465, updated PHYS 332

courses = [
  MATH_112, MATH_114, MATH_215, MATH_216, MATH_312, MATH_345,
  CHEM_105, CHEM_106, CHEM_109, CHEM_115,
  PHYS_115, PHYS_186, PHYS_226, PHYS_229, PHYS_231, PHYS_232,
  PHYS_240, PHYS_255, PHYS_308, PHYS_315, PHYS_332, PHYS_332_legacy,
  PHYS_333, PHYS_340, PHYS_350, PHYS_356, PHYS_360, PHYS_365, PHYS_367, 
  PHYS_375, PHYS_415, PHYS_430, PHYS_445, PHYS_465, PHYS_486,
  MSE_120, MSE_315, MSE_221, MSE_350, MSE_357, MSE_372, MSE_374, MSE_451
]

# firm up requirements so they work properly
for course in courses
  course.update_requirements(courses)


# Fall 2022: Removed PHYS 205, 361, 362, and 363, which were electives or required
# courses in each degree plan. PHYS 205 was a "basic elective" for the minor
# and appeared nowhere else
# Spring 2025: Added (deprecated) PHYS_332_legacy, deprecated PHYS 333 and
# PHYS 465, updated PHYS 332. Added PHYS 415.

degree_plan_data = [
  {
    name: 'Liberal Arts'
    credits_needed: 36
    counted:
      requirements: ['PHYS 186', 'PHYS 231', 'PHYS 232',
      'PHYS 350', 'PHYS 365', 'PHYS 486']
      choices: [[['PHYS 340'], ['PHYS 360']],
                [['PHYS 332'], ['PHYS 332 legacy']]]
    uncounted:
      requirements: ['MATH 312', 'PHYS 240']
      choices: []
    extra_electives: ['MSE 374', 'MSE 357', 'MSE 372', 'MSE 451']
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, PHYS_231, PHYS_232, PHYS_240]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, PHYS_332, PHYS_332_legacy, PHYS_333, PHYS_340, PHYS_350, PHYS_365]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_360, PHYS_486]
      },
      {
        title: 'Electives'
        courses: [PHYS_367, PHYS_375, PHYS_415, PHYS_430,
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
      requirements: ['PHYS 231', 'PHYS 232', 
      'PHYS 340', 'PHYS 350', 'PHYS 360', 'PHYS 430', 'PHYS 486']
      choices: [[['PHYS 186'], ['MSE 120']],
                [['PHYS 255', 'PHYS 356'], ['PHYS 365'], ['PHYS 375']],
                [['PHYS 332 legacy'], ['PHYS 332']]]
    uncounted:
      requirements: ['MATH 312', 'MATH 345', 'PHYS 240']
      choices: [[['CHEM 115'], ['CHEM 105', 'CHEM 106', 'CHEM 109']]]
    extra_electives: ['MSE 374', 'MSE 357', 'MSE 372', 'MSE 451']
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, MSE_120,
        PHYS_231, PHYS_232, PHYS_240, CHEM_105, CHEM_106, CHEM_109, CHEM_115]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, MATH_345, PHYS_255, PHYS_332, PHYS_332_legacy,
        PHYS_340, PHYS_350, PHYS_365]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_356, PHYS_360, PHYS_375, PHYS_430, PHYS_486]
      },
      {
        title: 'Electives'
        courses: [PHYS_333, PHYS_367, PHYS_415, PHYS_445,
          PHYS_465, MSE_315, MSE_357, MSE_372, MSE_374, MSE_451]
      },
      {
        title: 'Elective Support (uncounted towards major)'
        courses: [MSE_221, MSE_350]
      }
    ]
  },
  {
    name: 'Astrophysics'
    credits_needed: 36
    counted:
      requirements: ['PHYS 186', 'PHYS 231', 'PHYS 232', 'PHYS 332',
      'PHYS 340', 'PHYS 365', 'PHYS 367', 'PHYS 430', 'PHYS 486']
      choices: [[['PHYS 226'], ['PHYS 229']],
                [['PHYS 375'], ['PHYS 415'], ['PHYS 445'], ['PHYS 465']],
                [['PHYS 332 legacy'], ['PHYS 332']]]
    uncounted:
      requirements: ['MATH 312', 'PHYS 240']
      choices: []
    extra_electives: []
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, PHYS_186, PHYS_226,
          PHYS_229, PHYS_231, PHYS_232, PHYS_240]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, PHYS_332, PHYS_332_legacy, PHYS_333, PHYS_340,
        PHYS_367]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_365, PHYS_375, PHYS_415, PHYS_430, PHYS_445, PHYS_465, PHYS_486]
      },
      {
        title: 'Electives (not needed for credit towards major)'
        courses: [PHYS_350, PHYS_360]
      }
    ]
  },
  {
    name: 'Dual Degree'
    credits_needed: 36
    counted:
      requirements: ['MSE 120', 'PHYS 231', 'PHYS 232', 'PHYS 332',
      'PHYS 340', 'PHYS 350']
      choices: [[['PHYS 255', 'PHYS 356'], ['PHYS 365']],
                [['PHYS 332'], ['PHYS 332 legacy']]]
    uncounted:
      requirements: ['MATH 312', 'PHYS 240']
      choices: []
    extra_electives: ['MSE 374', 'MSE 357', 'MSE 372', 'MSE 451']
    course_groups: [
      {
        title: 'Introductory and Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215, MATH_216, MSE_120, PHYS_231, PHYS_232, PHYS_240]
      },
      {
        title: 'Intermediate Courses'
        courses: [MATH_312, PHYS_255, PHYS_332, PHYS_332_legacy, PHYS_340, PHYS_350, PHYS_365]
      },
      {
        title: 'Advanced Courses'
        courses: [PHYS_356]
      },
      {
        title: 'Electives'
        courses: [PHYS_333, PHYS_360, PHYS_367, PHYS_375, PHYS_415,
        PHYS_430, PHYS_445, PHYS_465, MSE_374, MSE_357, MSE_372, MSE_451]
      },
      {
        title: 'Elective Support (uncounted towards major)'
        courses: [CHEM_105, CHEM_106, CHEM_109, CHEM_115, MSE_221, MSE_350]
      }
    ]
  },
  {
    name: 'Minor'
    credits_needed: 24
    counted:
      requirements: ['PHYS 231', 'PHYS 232']
      choices: [[['PHYS 332'], ['PHYS 332 legacy']]]
    uncounted:
      requirements: ['MATH 215']
      choices: []
    extra_electives: ['PHYS 115', 'PHYS 186', 'PHYS 226', #, 'PHYS 205'
    'PHYS 229', 'PHYS 240', 'PHYS 308', 'PHYS 315']
    course_groups: [
      {
        title: 'Prerequisite Courses'
        courses: [MATH_112, MATH_114, MATH_215]
      },
      {
        title: 'Required Courses'
        courses: [PHYS_231, PHYS_232, PHYS_332, PHYS_332_legacy]
      },
      {
        title: 'Basic Electives'
        courses: [PHYS_115, PHYS_186, PHYS_226, PHYS_229, PHYS_240,
        PHYS_308, PHYS_315]
      },
      {
        title: 'Advanced Electives'
        courses: [PHYS_333, PHYS_340, PHYS_350, PHYS_356, PHYS_360,
        PHYS_365, PHYS_367, PHYS_375, PHYS_415, PHYS_430,
        PHYS_445, PHYS_465, PHYS_486]
      }
    ]
  }
]

# obsolete_degree_plans = [
#   {
#     name: 'LabVIEW'
#     credits_needed: 13
#     counted:
#       requirements: ['PHYS 350', 'PHYS 360', 'PHYS 361', 'PHYS 362', 'PHYS 363']
#       choices: []
#     uncounted:
#       requirements: []
#       choices: []
#     course_groups: [
#       {
#         title: 'Introductory and Prerequisite Courses'
#         courses: [MATH_112, MATH_114, MATH_215, PHYS_231, PHYS_232, PHYS_240]
#       },
#       {
#         title: 'Certificate Courses'
#         courses: [PHYS_350, PHYS_360, PHYS_361, PHYS_362, PHYS_363]
#       },
#     ]
#   }
# ]

get_course = (designation) ->
  # Parse the field and number from the designation
  field = designation.split(' ')[0]
  number = Number(designation.split(' ')[1])
  is_looking_for_deprecated = false
  
  # First check if the designation contains any deprecated terms
  for term in deprecated_synonyms
    is_looking_for_deprecated = is_looking_for_deprecated || designation.toLowerCase().includes(term)
  
  # Handle special case for PHYS 332
  if field == 'PHYS' && number == 332 
    # If specifically asking for legacy/deprecated version
    if is_looking_for_deprecated
      return PHYS_332_legacy
    
    # If asking for regular version (or unspecified)
    return PHYS_332
  
  # For all other courses, check if we're looking for a deprecated version  
  # First try to find an exact match with the deprecated status
  for course in courses
    if course.field == field && course.number == number && course.deprecated == is_looking_for_deprecated
      return course
      
  # If no exact match found, just match on field and number
  for course in courses
    if course.field == field && course.number == number
      return course
  
  console.error("No course found for: #{designation}")

# Find a course object from an HTML element ID
# This handles IDs with suffixes like "_legacy"
get_course_from_element_id = (element_id) ->
  # Split the ID by dashes
  parts = element_id.split('-')
  
  # Extract the field name and number
  if parts.length >= 2
    field = parts[0]
    number_with_suffix = parts[1]
    
    # Check if there's a suffix like "_legacy"
    has_legacy_suffix = number_with_suffix.includes('_')
    
    # For PHYS 332, we need special handling due to multiple versions
    if field == "PHYS" && number_with_suffix.startsWith("332")
      if has_legacy_suffix && number_with_suffix.includes("_legacy")
        # This is the legacy version
        return PHYS_332_legacy
      else if number_with_suffix == "332"
        # This is the new version
        return PHYS_332
    
    # For other courses or if PHYS 332 wasn't matched
    if has_legacy_suffix
      # Extract the base number without suffix
      base_number = number_with_suffix.split('_')[0]
      # Look up with legacy flag
      for course in courses
        if course.field == field && course.number.toString() == base_number && course.deprecated
          return course
    
    # Fall back to standard lookup if all else fails
    course_name = "#{field} #{number_with_suffix.split('_')[0]}"
    course = get_course(course_name)
    return course
  
  # If we couldn't parse the ID, log an error and return null
  console.error("Could not parse element ID: #{element_id}")
  return null

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

# Fall 2022: Removed PHYS 361, PHYS 362, and PHYS 363, which were "Intermediate
# Courses". Actually, only PHYS 361 was. PHYS 362 and PHYS 363 didn't appear.
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
      courses: [MATH_312, PHYS_255, PHYS_332, PHYS_332_legacy, PHYS_333, PHYS_340, PHYS_350, PHYS_365]
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
      
    # update required courses status
    required_complete = wizard.degree_plan.all_required_courses_complete()
    if required_complete
      $('#requirement-status').removeClass('text-danger').addClass('text-success')
      $('#requirement-status').text('Complete')
    else
      $('#requirement-status').addClass('text-danger').removeClass('text-success')
      $('#requirement-status').text('Incomplete')

    # update the course plan
    wizard.build_course_plan()

  set_degree_plan: (new_degree_plan) ->
    wizard.degree_plan = new_degree_plan
    wizard.clear_groups()
    for group in wizard.degree_plan.course_groups
      wizard.add_group(group)
    $('#credits-needed').html("#{new_degree_plan.credits_needed}")
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
        # Calculate the total credits for this term
        term_total_credits = 0
        for course in this_year_term_courses
          term_total_credits += course.credits
          
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
        
        # Add the credit summary row
        table_html += "    <tr class='bg-light font-weight-bold'>\n"
        table_html += "      <td colspan='2' class='text-right'>Term Total:</td>\n"
        table_html += "      <td>#{term_total_credits}</td>\n"
        table_html += "    </tr>\n"
        table_html += "  </tbody>\n"
    unless table_html == ""
      table_html = "<table class='table table-hover table-sm'>\n#{table_html}</table>\n"
      $('#course-plan').html("<h1 class='my-4'>Course Plan</h1>\n#{table_html}")

  setup_course_listeners: ->
    # activate switch listeners
    $('input.completed').click( ->
      # Get the ID of the checkbox
      checkbox_id = this.id
      
      # Get the course based on the element ID
      this_course = get_course_from_element_id(checkbox_id)
      
      this_course.toggle_completed()
      wizard.refresh(wizard.year_term)
    )
    
    $('input.enrolling').click( ->
      # Get the ID of the checkbox
      checkbox_id = this.id
      
      # Get the course based on the element ID
      this_course = get_course_from_element_id(checkbox_id)
      
      this_course.toggle_enrolling()
      wizard.refresh(wizard.year_term)
    )

    # activate modal description listeners
    $('button.description').click( ->
      # Store the original button ID to help track which course we're dealing with
      button_id = this.id
      
      # Get the course based on the button's ID
      course = get_course_from_element_id(button_id)
      
      # Update modal content for this course
      course.update_modal(wizard.year_term)
      $('#course-info').modal()

      # Set the current course in a data attribute so we know which one to manipulate
      $('#course-info').data('current-course', course)

      $('#modal-enrolling').click( (event) ->
        event.preventDefault
        # Get the course from the data attribute we set above
        course = $('#course-info').data('current-course')
        course.enrolling = true
        course.completed = false
        wizard.refresh(wizard.year_term)
        $('#course-info').modal('hide')
      )
      
      $('#modal-completed').click( (event) ->
        event.preventDefault
        # Get the course from the data attribute we set above
        course = $('#course-info').data('current-course')
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

  # enable popovers  
  $('[data-toggle="popover"]').popover()
  $('.popover-dismiss').popover({
    trigger: 'focus'
  })
  $('a#print-page').click( (event) ->
    event.preventDefault()
    window.print()
    setTimeout("window.close()", 100)
  )
)
