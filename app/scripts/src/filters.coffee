angular.module('scottyFilters', []).
    filter 'truncate', ()->
        return (text, length = 100, end = '...')->
            if  text.length <= length or text.length - end.length <= length
                return text

            return String(text).substring(0, length-end.length) + end
