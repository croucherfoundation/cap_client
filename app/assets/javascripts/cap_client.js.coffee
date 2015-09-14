jQuery ($) ->

  # The institution or employer picker is a compound control that supports the usual logic of
  # institution-in-country or employer-with-address.
  #
  $.fn.application_picker = ->
    @each ->
      new ApplicationPicker @
    @

  class ApplicationPicker
    constructor: (element) ->
      @_container = $(element)
      @_cache = {}
      @_previous_values = []

      @_year_chooser = @_container.find('[data-role="year"]')
      @_round_chooser = @_container.find('[data-role="round"]')
      @_application_chooser = @_container.find('[data-role="application"]')
      @_rounds_url = @_select.attr('data-rounds-url') ? '/cap/rounds'
      @_applications_url = @_select.attr('data-applications-url') ? '/cap/applications'

      @_year_chooser.restricts @_round_chooser
      @_round_chooser.on "refresh", @restrictToYear
      @_round_chooser.restricts @_application_chooser
      @_application_chooser.on "refresh", @restrictToRound

    restrictToYear: (e, year) =>
      @_round_select.empty()
      @_rounds_request?.abort()
      if data = @_cache["year_#{year}"]
        @setOptions(data, @_round_chooser)
      else
        @_year = year
        @_round_select.addClass('waiting')
        @_rounds_request = $.getJSON "#{@_rounds_url}/#{year}", @receiveRounds

    receiveRounds: (data) =>
      @_cache["year_#{@_year}"] = data
      @_select.removeClass('waiting')
      @setOptions(data, @_round_chooser)

    restrictToRound: (e, round_id) =>
      @_application_select.empty()
      @_applications_request?.abort()
      if data = @_cache["round_#{round_id}"]
        @setOptions(data, @_application_chooser)
      else
        @_round_id = round_id
        @_application_select.addClass('waiting')
        @_applications_request = $.getJSON "#{@_applications_url}/#{round_id}", @receiveApplications

    receiveApplications: (data) =>
      @_cache["round_#{@_round_id}"] = data
      @_select.removeClass('waiting')
      @setOptions(data, @_application_chooser)

    setOptions: (data, chooser) =>
      @appendOption("", "", chooser)
      for [name, code] in data
        @appendOption(name, code)

    appendOption: (name, code, chooser) =>
      chooser.append $("<option />").val(code).text(name)


