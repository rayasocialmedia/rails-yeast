// Auto-submit forms when users hit Enter/Return button
$('.auto-submit').live('keydown',function(e){
  if (e.keyCode == 13 && !e.shiftKey) {
    $(this).parents('form').trigger('submit.rails');
    $(this).val('');
    e.preventDefault();
  }
});

// Auto-resize text elements when users hit Enter/Return
$('.auto-resize').live('keydown',function(e){
  if (e.keyCode == 13) {
    $(this).height(this.scrollHeight);
  }
});


// HTML5 Placeholders in older browsers
$(function() {
  if(!$.support.placeholder) { 
    var active = document.activeElement;
    $('textarea, :text').focus(function () {
      if ((typeof $(this).attr('placeholder') !== 'undefined' && $(this).attr('placeholder') !== false) && $(this).attr('placeholder') != '' && $(this).val() == $(this).attr('placeholder')) {
        $(this).val('').removeClass('hasPlaceholder');
      }
    }).blur(function () {
      if ((typeof $(this).attr('placeholder') !== 'undefined' && $(this).attr('placeholder') !== false) && $(this).attr('placeholder') != '' && ($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))) {
        $(this).val($(this).attr('placeholder')).addClass('hasPlaceholder');
      }
    });
    $('textarea, :text').blur();
    $(active).focus();
    $('form').submit(function () {
      $(this).find('.hasPlaceholder').each(function() { $(this).val(''); });
    });
  }
});