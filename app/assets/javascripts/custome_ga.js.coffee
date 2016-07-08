# NOTE: These won't get fired off unless they're in the
# production environment -- see app/views/shared/_ga.html.erb
# for the code doing that.  
# format: ('_trackEvent', category, action, label, value)
$ ->
  # Fire a custom analytics event whenever any link is clicked
  $('a').on 'click', (e) ->
    $target = $(e.target)
    href = $target.attr('href')
    # manually set href for elements wrapped in anchor tags
    # this is because the click event target is actually the
    # internal element, e.g. an <h3> tag wrapped in <a> tags
    # will register a click target of <h3> not <a> so the
    # "href" property will be undefined and we must check its
    # parents to acquire the href.
    if !href
      href = $target.parents('a').attr('href')
    # Send separate events for internal and external link clicks
    regexp = /^http:/
    if regexp.test(href)
      _gaq.push [
        '_trackEvent'
        'external_link'
        'click'
        href
        1
      ]
    else
      _gaq.push [
        '_trackEvent'
        'internal_link'
        'click'
        href
        1
      ]
    return
  # Fire an event on submit
  $('#custom-track').on 'click', (e) ->
    _gaq.push [
      '_trackEvent'
      'subscribe'
      'mailchip'
      'home-page'
      1
    ]
    return
  return