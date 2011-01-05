// application function define
  function set_title(photo_id){
      $('#photo_set_title_' + photo_id).show();
      $('#set_title_' + photo_id).hide();
      $('#delete_link_' + photo_id).hide();$('#sumbit_link_' + photo_id).show();
      };    

// bind script
  $(document).ready(function(){
    $(".open_dialog").click(function(){dialog($(this).attr('title'),("url:"+$(this).attr('href')),"570px","auto","text");  return false;})
    $('#dialog_flash a').click();
    $('.more_items').click(function(){
      var container = $(this);
      container.html('读取中...')
      $.get(container.attr('href'),function(data){container.replaceWith(data)})
      return false;
      });
    $('.with_tip').poshytip({
      className: 'tip-yellowsimple',
      showOn: 'focus',
      alignTo: 'target',
      alignX: 'right',
      alignY: 'center',
      offsetX: 5
    });
    
    $('.with_explain').poshytip({
      className: 'tip-yellowsimple',
      showTimeout: 1,
      alignTo: 'target',
      alignX: 'center',
      offsetY: 5,
      allowTipHover: false
    });
    
    $(".event_box").hover(
      function () {
        $(this).addClass("hover");
      },
      function () {
        $(this).removeClass("hover");
      }
    );
    
    if(!('placeholder' in document.createElement('input'))){
      $('input[placeholder!=""]').hint();
    };
    
    $(".upload_photo_link").click(function(){dialog($(this).attr('title'),("id:upload_photo_" + $(this).attr('tag')),"570px","auto","text");  return false;});
    
    $(".tabContents").hide(); // Hide all tab conten divs by default
    $(".tabContents:first").show(); // Show the first div of tab content by default
    $("#tabContaier ul li a:first").addClass("active");
    $("#tabContaier ul li a").click(function(){ //Fire the click event
      var activeTab = $(this).attr("href"); // Catch the click link
      $("#tabContaier ul li a").removeClass("active"); // Remove pre-highlighted link
      $(this).addClass("active"); // set clicked link to highlight state
      $(".tabContents").hide(); // hide currently visible tab content div
      $(activeTab).fadeIn(); // show the target tab content div by matching clicked link.
      return false;
    });

    $('pre').each(function(index){$(this).html($(this).html().replace(/(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-|!)+)/g, "<a href='$1$2' target='_blank' rel='nofollow'>$1$2</a>"))})

  })
  