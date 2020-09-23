// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage

//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require_tree .
//= require_self
//= require activestorage
//= require jquery.jscroll.min.js




$(document).ready(function(){

  // ローディング中のアニメーションを制御
  $(function(){
    var loader = $('.loader-wrap');

    $(window).on('beforeunload',function(){
        loader.fadeIn();
    });

    $(window).on('load',function(){
      loader.fadeOut();
    });

    $(window).on('onresize',function(){
      loader.fadeIn();
    });
  });

  // テキストエリアの欄を記入されたテキストに合わせて広げる
  var $textarea = $('#textarea');
  var lineHeight = parseInt($textarea.css('lineHeight'));
  $textarea.on('input', function(e){
    var lines = ($(this).val() + '\n').match(/\n/g).length;
    $(this).height(lineHeight * lines);
  });


});
