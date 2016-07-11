angular.module('paymentTestingApp.services').service  '$suburbService', [
  '$resource'
  '$rootScope'
  'api_config'
  ($resource,$rootScope,api_config) ->

    @actions =
      load:  api_config.api_end_point+"/load"

    @checkoutData = {}

    @SuburbsService = (opts)->
      options = opts
      urls = @actions
      self = @

      return {
        ###
          Load Payment Data From The API
        ###
        init: ()->
          dataSource = $resource urls.load
          return dataSource.get()
      }
]
