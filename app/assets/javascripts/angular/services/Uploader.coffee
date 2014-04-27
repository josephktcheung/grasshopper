Grasshopper.factory 'Uploader', ['$fileUploader', ($fileUploader) ->
  Uploader =
    createLoader: (scope, User) ->
      csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      uploader = $fileUploader.create({
        alias: 'avatar'
        scope: scope
        url: './api/users/' + scope.currentUser.id
        method: 'PUT'
        headers:
          'X-CSRF-TOKEN': csrf_token
        queueLimit: 1
        })

      uploader.filters.push (item) ->
        type = if uploader.isHTML5 then item.type else item.value.slice(item.value.lastIndexOf('.') + 1)
        type = '|' + type.toLowerCase().slice(type.lastIndexOf('/') + 1) + '|'
        '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1

      uploader.bind 'success', (event, xhr, items, response) ->
        noty { text: 'Successfully changed profile photo!', type: 'success'}
        uploader.clearQueue()
        User.loadCurrentUser().then (data) ->
          scope.currentUser = data.users[0]

      uploader.bind 'error', (event, xhr, items, response) ->
        noty { text: 'Profile photo cannot be changed! Please try again', type: 'error'}
        uploader.clearQueue()
      uploader
  Uploader
]