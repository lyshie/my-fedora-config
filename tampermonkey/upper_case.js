// ==UserScript==
// @name         Upper Case
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Upper Case
// @author       Hsieh Li-Yi
// @match        https://read.moe.edu.tw/*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function ($, undefined) {
    $(function () {
        'use strict';

        function toTitleCase(str)
        {
            return str.replace(/(?:^|\w)\S*/g, function(txt) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            });
        }

        // auto upper case first letter
        $('input:text').on('change', function() {
            var line = toTitleCase($(this).val());
            $(this).val(line);
        });
    });
})(window.jQuery.noConflict(true));
