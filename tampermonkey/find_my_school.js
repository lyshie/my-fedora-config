// ==UserScript==
// @name         Find My School
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  Find My School
// @author       Hsieh Li-Yi
// @match        *://*.edu.tw/*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function ($, undefined) {
    $(function () {
        'use strict';

        // statically created
        $('option').each(function() {
            var t = $(this).text();
            if (t.match(/進學/)) {
                $(this).text('---- ' + t + ' ----')
                    .css('font-size', '16pt')
                    .css('color', 'red')
                    .css('font-weight', 'bolder')
                    .css('background-color', 'yellow')
                    .attr('selected', 'selected');
            }
        });

        // dynamically created
        $('select').click(function() {
            $(this).find('option').each(function() {
                var t = $(this).text();
                if (t.match(/進學/)) {
                    $(this).text('---- ' + t.replace(/[\-\s]+/g, '') + ' ----')
                        .css('font-size', '16pt')
                        .css('color', 'red')
                        .css('font-weight', 'bolder')
                        .css('background-color', 'yellow')
                        .attr('selected', 'selected');
                }
            });
        });
    });
})(window.jQuery.noConflict(true));
