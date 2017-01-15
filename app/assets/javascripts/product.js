
productIndexDisplay = function(){
  $('.product-image').on('mouseenter', function(){
    $(this).children('div .product-info').fadeIn();
    $(this).on('mouseleave', function(){
      $(this).children('div .product-info').fadeOut();
    });
  });
}

$(document).on('turbolinks:load', productIndexDisplay);
