app = function() {
  return {
    Name: function() {
      return "pvdemo-datadog"; //Replace with any friendly name you
    },
    IsRequestSupported: function(r,c) {
      return true;
    },
    GetContainerInfo: function(r,c) {
      return {
        ID:                 "pvdemo-datadog",
        BaseImage:          "polyverse/pvdemo-datadog", //Put your application’s image name here
        Timeout:            365 * 24 * 60 * 60 * 1000000000,
        PerInstanceTimeout: 5 * 1000000000, //How often do you want to replace instances (in nanoseconds)? Default: 5 seconds
        DesiredInstances:   100, //How many containers do you want running concurrently
        IsStateless:        true,
        HealthCheckURLPath: "/" ,
        LaunchGracePeriod:  60 * 1000000000,
        Cmd:               [], // Optional. Specify arguments to be sent to container on launch
        BindingPort:        8080 // Specify the port that your container application is listening to
      };
    },
    ValidationInfo: function() {
      return {
        PositiveRequests: [],
        NegativeRequests: []
      };
    }
  };
}();
