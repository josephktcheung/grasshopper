Grasshopper.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.header.common.Accept = "application/json"
