$('.comment-feed').on('click', '.show-comments', function(event) {
  event.preventDefault();
  $showCommentsLink = $(event.target);
  $comments = $showCommentsLink.parent().find('.comment-feed-comments');
  $comments.toggle(300);
});

$('.add-comment').click(function(e){
  e.preventDefault();
  $(e.target.parentElement).find('.comment-form').toggle(300);
});