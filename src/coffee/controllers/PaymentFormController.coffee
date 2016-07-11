angular.module("paymentTestingApp.controllers").controller 'PaymentFormController' , [
  "$scope"
  "$paymentService"
  "$suburbService"
  "$filter"
  "$routeParams"
  ($scope,$paymentService,$filter,$routeParams)->

    $scope.init = ()->
      $scope.paymentService = $paymentService.Payment()
      $scope.suburbService = $suburbService.Suburb()

      ###
      $scope.personalData = $scope.paymentService.personalData()
      $scope.shipmentData = $scope.paymentService.shipmentData()
      $scope.creditCardData = $scope.paymentService.creditCardData()
      ###

      $scope.personalData   = {}
      $scope.shipmentData   = {}
      $scope.creditCardData = {}

      $scope.paymentService.init().$promise.then((result)->
        if result.personalData?
          $scope.personalData = result.personalData
        if result.shipmentData?
          $scope.shipmentData = result.shipmentData
        if result.creditCardData?
          $scope.creditCardData = result.creditCardData
        if result.currentStep?
          $scope.currentStep = result.currentStep
      )

      $scope.suburbService.init().$promise.then((result)->
        if result.suburbs?
          $scope.suburbs = result.suburbs
      )

      console.log $routeParams

    $scope.nextStep = ()->
      if !$scope.validateStep()
        return
      switch $scope.step
        when 1 then $scope.paymentService.save $scope.personalData
        when 2 then $scope.paymentService.save $scope.shipmentData
        when 2 then $scope.paymentService.processCheckout $scope.creditCardData

      ###
        Go to next step
      ###

    $scope.validateStep = ()->
      return true
]
