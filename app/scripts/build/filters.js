(function() {
  angular.module('scottyFilters', []).filter('truncate', function() {
    return function(text, length, end) {
      if (length == null) {
        length = 100;
      }
      if (end == null) {
        end = '...';
      }
      if (text.length <= length || text.length - end.length <= length) {
        return text;
      }
      return String(text).substring(0, length - end.length) + end;
    };
  });

}).call(this);
