angular.module('paymentTestingApp.services').service  '$paymentService', [
  '$resource'
  '$rootScope'
  'api_config'
  ($resource,$rootScope,api_config) ->

    @actions =
      save:  api_config.api_end_point+"?action=save"
      load:  api_config.api_end_point+"?action=load"

    @checkoutData = {}

    @PaymentService = (opts)->
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

        save: ()->
          dataSource = $resource urls.save
          dataSource.post self.checkoutData, (response)->

      }

    return
]
