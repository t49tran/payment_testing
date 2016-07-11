angular.module("paymentTestingApp.controllers").controller('PaymentFormController', [
  "$scope", "$paymentService", "$filter", "$routeParams", function($scope, $paymentService, $filter, $routeParams) {
    $scope.init = function() {
      $scope.paymentService = $paymentService.Payment();

      /*
      $scope.personalData = $scope.paymentService.personalData()
      $scope.shipmentData = $scope.paymentService.shipmentData()
      $scope.creditCardData = $scope.paymentService.creditCardData()
       */
      return $scope.paymentService.init().$promise.then(function(result) {});
    };
    return $scope.nextStep = function() {
      return $scope;
    };
  }
]);
