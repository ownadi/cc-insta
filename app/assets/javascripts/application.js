// This is a manifest file that'll be compiled into application.js, which will
// include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts,
// vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here
// using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at
// the bottom of the compiled file. JavaScript code in this file should be
// added after the last require_* statement.
//
// Read Sprockets README:
// https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require isInViewport
//= require bootstrap/affix
//= require bootstrap/alert
//= require bootstrap/button
//= require bootstrap/carousel
//= require bootstrap/collapse
//= require bootstrap/dropdown
//= require bootstrap/modal
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require bootstrap/scrollspy
//= require bootstrap/tab
//= require bootstrap/transition
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.btn-upload > input').change(function(event) {
    var file = event.target.files[0];
    var reader = new FileReader();

    reader.onload = function(output) {
      App.images.perform('upload', { file: output.target.result });
    };

    reader.readAsDataURL(file);
  });

  $('.load-more > a').click(function(clickEvent) {
    clickEvent.preventDefault();
    $(clickEvent.target).remove();
    window.totalPages = +$('meta[name="total_pages"]').attr('content');
    window.pageLoading = false;
    window.infiniteScrollHandler = function(event) {
      if($(window).scrollTop() + $(window).height() == $(document).height() && !pageLoading) {
        var nextPage = +(qs('page') || 1) + 1;
        if(nextPage > totalPages) {
          $(window).unbind('scroll', infiniteScrollHandler);
          return;
        }

        pageLoading = true;
        $.get("/?page=" + nextPage, function(data) {
          $('.img-grid').after(data);
          setTimeout(function() {
            pageLoading = false;
          }, 5000);
        });
      }
    }

    $(window).scroll(infiniteScrollHandler);

    $(window).scroll(function(event) {
      var pagesInViewport = $.map($('.img-grid:in-viewport'), function(element) {
        return $(element).data('page');
      });
      var currentPage = +pagesInViewport[pagesInViewport.length - 1];
      if(+qs('page') != currentPage)
        history.replaceState({}, '', updateQueryStringParameter(window.location.href, 'page', currentPage));
    });
  });
});

$(document).on('turbolinks:render', function() {
  $(window).unbind('scroll');
  if(cableConnected) {
    $('.loader-upload').hide();
    $('.btn-upload').show();
  };
});

function qs(key) {
  key = key.replace(/[*+?^$.\[\]{}()|\\\/]/g, "\\$&");
  var match = location.search.match(new RegExp("[?&]"+key+"=([^&]+)(&|$)"));
  return match && decodeURIComponent(match[1].replace(/\+/g, " "));
}

function updateQueryStringParameter(uri, key, value) {
  var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
  var separator = uri.indexOf('?') !== -1 ? "&" : "?";
  if (uri.match(re)) {
    return uri.replace(re, '$1' + key + "=" + value + '$2');
  }
  else {
    return uri + separator + key + "=" + value;
  }
}
