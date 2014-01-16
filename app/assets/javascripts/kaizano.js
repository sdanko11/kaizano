$('.question-object').on('click', '.comment-link', function(event) {
  event.preventDefault();
  $showCommentsLink = $(event.target);
  $comments = $showCommentsLink.parent().find('.comment-object');
  $comments.toggle(300);
});


$(".question-link").click(function(event){
  event.preventDefault();
  $(".question-table-content").toggle(300);
});

$(".feedback-link").click(function(event){
  event.preventDefault();
  $(".feedback-table-content").toggle(300);
});