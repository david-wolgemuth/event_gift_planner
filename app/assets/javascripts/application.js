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
//= require turbolinks
//= require jquery3
//= require_tree .
function ready () {
  'use strict';
  const $xmodalsContainer = $('#xmodals-container');
  const $xmodals = $xmodalsContainer.find('.xmodal');
  const $xmodalTriggers = $('*[data-xmodal-target]');

  const $confirmationModalTriggers = $('*[data-confirm-title], *[data-confirm-message]');

  function xmodalTriggerClicked (event) {
    event.preventDefault();
    $xmodals.addClass('hidden-xs-up');
    const xmodalName = 'xmodal-' + $(this).data('xmodal-target');
    const $xvisibleModals = $xmodalsContainer.find('.' + xmodalName).removeClass('hidden-xs-up');
    if ($xvisibleModals.get(0)) { }
  }
  function xmodalCloseTriggered (event) {
    event.preventDefault();
    const $xmodal = $(this).closest('.xmodal');
    $xmodal.addClass('hidden-xs-up');
  }
  function xmodalClickedOutsideContent (event) {
    if (!$(event.target).hasClass('xmodal')) {
      return;
    }
    const $xmodal = $(this).closest('.xmodal');
    $xmodal.addClass('hidden-xs-up');
  }

  $xmodalTriggers.click(xmodalTriggerClicked);

  function presentConfirmationModal (event) {
    const $trigger = $(this);
    if ($trigger.data('confirmed')) {
      // Second time through after retrigger
      return;
    }
    event.preventDefault();
    const $xmodal = $xmodalsContainer.find('.xmodal-confirmationmodal').removeClass('hidden-xs-up');
    $xmodal.find('h3').text($trigger.data('confirm-title'));
    $xmodal.find('p').text($trigger.data('confirm-message'));
    $xmodal.find('button').off('click');
    $xmodal.find('button.cancel-confirm').click(function () {
      $xmodal.addClass('hidden-xs-up');
    });
    $xmodal.find('button.ok-confirm').click(function () {
      $trigger.data('confirmed', true);
      if ($trigger.is('form')) {
        $trigger.get(0).submit();
      } else {
        $trigger.get(0).click();
      }
    });
  } 

  $confirmationModalTriggers.submit(presentConfirmationModal);
  $confirmationModalTriggers.click(presentConfirmationModal);
  
  $xmodals.on('click', '.xmodal-x', xmodalCloseTriggered);
  $xmodals.on('click', xmodalClickedOutsideContent);
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready); 
