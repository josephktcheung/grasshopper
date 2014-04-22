Grasshopper.controller "SearchCtrl", ['$scope', '$location', 'Restangular', 'getCurrentUser', ($scope, $location, Restangular, getCurrentUser) ->

  initialize = () ->
    baseUsers = Restangular.all('users')
    baseUsers.getList().then (users) ->
      $scope.users = users

  $scope.currentUser = getCurrentUser.currentUser

  getCurrentUser.loadData()

  initialize()

  $scope.viewProfile = () ->
    $location.url '/view-profile'

  $scope.searchText = ''

  $scope.filterByNameOrSkill = (users,searchText) ->
    filteredUsers = []
    searchTextRegExp = RegExp(searchText, 'i')

    angular.forEach users, (user) ->
      if user.first_name.match(searchTextRegExp) or user.last_name.match(searchTextRegExp)
        isMatch = true
      else angular.forEach user.links.proficiencies, (proficiency) ->
        if proficiency.skill.match(searchTextRegExp)
          isMatch = true
      filteredUsers.push user if isMatch == true
    filteredUsers


  $("ul.nav.nav-pills.nav-justified li a").click () ->
    $(this).parent().addClass("active").siblings().removeClass "active"
    users = $scope.users
    # if $(this).id == "all"
    #   $scope.users = users
    # else if $(this).id == "masters"
    #   $scope.users = getMasters(users)
    # else if $(this).id == "grasshoppers"
    #   $scope.users = getGrasshoppers(users)
    return

  getMasters = (users) ->
    masters = _.where(users, { 'role': 'master' });
    return masters

  getGrasshoppers = (users) ->
    grasshoppers = _.where(users, { 'role': 'grasshopper' });
    return grasshoppers

]

