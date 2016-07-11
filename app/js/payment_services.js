angular.module('paymentTestingApp.services').service('$paymentService', [
  '$resource', '$rootScope', 'api_config', function($resource, $rootScope, api_config) {
    this.actions = {
      save: api_config.api_end_point + "/save",
      load: api_config.api_end_point + "/load"
    };
    this.checkoutData = {};
    this.PaymentService = function(opts) {
      var options, self, urls;
      options = opts;
      urls = this.actions;
      self = this;
      return {

        /*
          Load Payment Data From The API
         */
        load: function() {
          var dataSource;
          dataSource = $resource(urls.load);
          return dataSource.get();
        },
        save: function() {
          var dataSource;
          dataSource = $resource(urls.save);
          return dataSource.post(self.checkoutData, function(response) {});
        }
      };
    };
  }
]);
