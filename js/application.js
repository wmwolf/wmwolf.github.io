function viewport()
{
  var viewportwidth;
  var viewportheight;
  
  // the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
  
  if (typeof window.innerWidth != 'undefined')
  {
       viewportwidth = window.innerWidth,
       viewportheight = window.innerHeight
  }
  
 // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
 
  else if (typeof document.documentElement != 'undefined'
      && typeof document.documentElement.clientWidth !=
      'undefined' && document.documentElement.clientWidth != 0)
  {
        viewportwidth = document.documentElement.clientWidth,
        viewportheight = document.documentElement.clientHeight
  }
  
  // older versions of IE
  
  else
  {
        viewportwidth = document.getElementsByTagName('body')[0].clientWidth,
        viewportheight = document.getElementsByTagName('body')[0].clientHeight
  }
  return viewportwidth
}

$( document ).ready(function() {
  if (viewport() > 768)
  {
    boxes = $('.panel').not(".no-height-fix");
    maxHeight = Math.max.apply(
    Math, boxes.map(function() {
        return $(this).height();
    }).get());
    boxes.height(maxHeight);
  }
});

$( window ).resize(function() {
  boxes = $('.panel').not(".no-height-fix");
  boxes.height("auto")
  if (viewport() > 768)
  {
    maxHeight = Math.max.apply(
    Math, boxes.map(function() {
        return $(this).height();
    }).get());
    boxes.height(maxHeight);
  }
});
$( document ).ready(function() {
  // expand recent papers box if not expanded, contract it otherwise
  $('.expandable').on('click', function(event) {
    event.preventDefault();
    $(this).closest(".panel").find(".toggle").slideToggle();
    $(this).find('span').toggleClass("glyphicon-chevron-down");
    $(this).find('span').toggleClass("glyphicon-chevron-up")   ; 
  });
}
);
