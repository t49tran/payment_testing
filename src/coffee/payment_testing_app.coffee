###
  Bootstrapping the application here
###
angular.module('paymentTestingApp.services',[])

angular.module('paymentTestingApp.directives',['paymentTestingApp.services'])

angular.module('paymentTestingApp.controllers',['paymentTestingApp.services'])

angular.module('paymentTestingApp', [
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'paymentTestingApp.services',
    'paymentTestingApp.directives',
    'paymentTestingApp.controllers'
]).config(
  ($routeProvider)->
    step_one = 1

    $routeProvider.when('/:payment_step', {
      templateUrl: (routeParams)->
        console.log routeParams
        return "payment_step_"+routeParams.payment_step+".html"
    })
    .otherwise(redirectTo: '/'+step_one)
)
