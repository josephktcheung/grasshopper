Grasshopper.config( (RestangularProvider) ->

  RestangularProvider.setBaseUrl('/api')

  RestangularProvider.addResponseInterceptor( (response, operation, route, url) ->
    if operation == 'getList'
      newResponse = response[route]
    else
      newResponse = response
    newResponse
  )
)