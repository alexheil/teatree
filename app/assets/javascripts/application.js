//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var menuToggle = function() {

  $('#menu-click').click(function() {
    $('#menu-container').fadeIn(300);
    $('.back').fadeIn(300);
    $(".wrapper").addClass("blur");
    $('.background').addClass('blur');
  });

  $('.back').click(function() {
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
    $('.background').removeClass('blur');
  });

  $('#close-menu').click(function() {
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
    $('.background').removeClass('blur');
  });

};

$(document).ready(menuToggle);
$(document).on('turbolinks:load', menuToggle);

var flashTimeout = function() {

  setTimeout(function() {
    $('.flash_js').fadeOut();
  }, 5000);

};

$(document).ready(flashTimeout);
$(document).on('turbolinks:load', flashTimeout);

var getFilename = function() {

  $('input[type="file"]').change(function(e){
    var fileName = e.target.files[0].name;
    $('.file-name').text(fileName);
    $('.file-name').addClass('padding-top');
  });

};

$(document).ready(getFilename);
$(document).on('turbolinks:load', getFilename);

var videoClick = function() {

  $('#expand-description').click(function() {
    $('#description-container').fadeIn(300);
    $('.back').fadeIn(300);
    $(".wrapper").addClass("blur");
  });

  $('#share-button-click').click(function() {
    $('#share-container').fadeIn(300);
  });

  $('.back').click(function() {
    $('#description-container').fadeOut(300);
    $('#copy-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
  });

};

$(document).ready(videoClick);
$(document).on('turbolinks:load', videoClick);

var sidebarTabs = function() {

  $('#first-tab-click').click(function() {
    $('#first-tab').fadeIn(300);
    $('#first-tab-click').addClass('active-sidebar-tab');
    $('#first-tab-click').removeClass('inactive-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#second-tab-click').click(function() {
    $('#second-tab').fadeIn(300);
    $('#second-tab-click').addClass('active-sidebar-tab');
    $('#second-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#third-tab-click').click(function() {
    $('#third-tab').fadeIn(300);
    $('#third-tab-click').addClass('active-sidebar-tab');
    $('#third-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#fourth-tab-click').click(function() {
    $('#fourth-tab').fadeIn(300);
    $('#fourth-tab-click').addClass('active-sidebar-tab');
    $('#fourth-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#fifth-tab-click').click(function() {
    $('#fifth-tab').fadeIn(300);
    $('#fifth-tab-click').addClass('active-sidebar-tab');
    $('#fifth-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#sixth-tab-click').click(function() {
    $('#sixth-tab').fadeIn(300);
    $('#sixth-tab-click').addClass('active-sidebar-tab');
    $('#sixth-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#seventh-tab-click').click(function() {
    $('#seventh-tab').fadeIn(300);
    $('#seventh-tab-click').addClass('active-sidebar-tab');
    $('#seventh-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
  });


};

$(document).ready(sidebarTabs);
$(document).on('turbolinks:load', sidebarTabs);

var emailTabs = function() {

  $('#first-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#first-email-tab').addClass("active-paid-tab");
      $('#first-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#first-email-tab').removeClass("active-paid-tab");
      $('#first-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#second-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#second-email-tab').addClass("active-paid-tab");
      $('#second-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#second-email-tab').removeClass("active-paid-tab");
      $('#second-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#third-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#third-email-tab').addClass("active-paid-tab");
      $('#third-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#third-email-tab').removeClass("active-paid-tab");
      $('#third-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#fourth-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#fourth-email-tab').addClass("active-paid-tab");
      $('#fourth-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#fourth-email-tab').removeClass("active-paid-tab");
      $('#fourth-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#fifth-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#fifth-email-tab').addClass("active-paid-tab");
      $('#fifth-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#fifth-email-tab').removeClass("active-paid-tab");
      $('#fifth-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#sixth-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#sixth-email-tab').addClass("active-paid-tab");
      $('#sixth-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#sixth-email-tab').removeClass("active-paid-tab");
      $('#sixth-email-tab').addClass("inactive-paid-tab");
    }
  });

  if ($('#first-email-inactive').prop('checked')) {
    $('#first-email-tab').addClass("active-paid-tab");
    $('#first-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#second-email-inactive').prop('checked')) {
    $('#second-email-tab').addClass("active-paid-tab");
    $('#second-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#third-email-inactive').prop('checked')) {
    $('#third-email-tab').addClass("active-paid-tab");
    $('#third-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#fourth-email-inactive').prop('checked')) {
    $('#fourth-email-tab').addClass("active-paid-tab");
    $('#fourth-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#fifth-email-inactive').prop('checked')) {
    $('#fifth-email-tab').addClass("active-paid-tab");
    $('#fifth-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#sixth-email-inactive').prop('checked')) {
    $('#sixth-email-tab').addClass("active-paid-tab");
    $('#sixth-email-tab').removeClass("inactive-paid-tab");
  };

};

$(document).ready(emailTabs);
$(document).on('turbolinks:load', emailTabs);

var editProfile = function() {

  $('#remove-image-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#remove-image-tab').addClass("active-removal-tab");
      $('#remove-image-tab').removeClass("inactive-removal-tab");
    } else {
      $('#remove-image-tab').removeClass("active-removal-tab");
      $('#remove-image-tab').addClass("inactive-removal-tab");
    }
  });

};

$(document).ready(editProfile);
$(document).on('turbolinks:load', editProfile);

var imageLoading = function() {

  $('.thumbnail-image-feed-four').fadeIn(1000);
  $('.thumbnail-image-mini').fadeIn(1000);
  $('.thumbnail-image').fadeIn(1000);
  $('.video-player').fadeIn(1000);
  $('.thumbnail-image-category').fadeIn(1000);
  $('.category-image-container').fadeIn(1000);
  $('.thumbnail-image-home').fadeIn(1000);

};

$(document).ready(imageLoading);
$(document).on('turbolinks:load', imageLoading);

var freePremium = function() {

  if ($('#premium').prop('checked')) {
    $('#free-tab').addClass("inactive-paid-tab");
    $('#free-tab').removeClass("active-paid-tab");
    $('#premium-tab').addClass("active-paid-tab");
    $('#premium-tab').removeClass("inactive-paid-tab");
  };

  $('#free').click(function() {
    $('#free-tab').removeClass("inactive-paid-tab");
    $('#free-tab').addClass("active-paid-tab");
    $('#premium-tab').removeClass("active-paid-tab");
    $('#premium-tab').addClass("inactive-paid-tab");
  });

  $('#premium').click(function() {
    $('#free-tab').addClass("inactive-paid-tab");
    $('#free-tab').removeClass("active-paid-tab");
    $('#premium-tab').addClass("active-paid-tab");
    $('#premium-tab').removeClass("inactive-paid-tab");
  });

};

$(document).ready(freePremium);
$(document).on('turbolinks:load', freePremium);