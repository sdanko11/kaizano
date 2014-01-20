$(document).ready(function() {
$('.question-object').on('click', '.comment-link', function(event) {
  event.preventDefault();
  $showCommentsLink = $(event.target);
  $comments = $showCommentsLink.parent().find('.comment-object');
  $comments.toggle(300);
 });

$('.new_question_comment').on('submit', function(event) {
  event.preventDefault();
  $form = $(event.currentTarget);
  $.ajax({
    type: "POST",
    url: $form.attr('action'),
    data: $form.serialize(),
    dataType: "json",
    success: function(data) {
    $form.siblings().first().append("<h6>"+ "-" + data.body + "</h6><br>")
    $form.each (function() { this.reset(); });
    }
  });
});

$(".question-link").click(function(event){
  event.preventDefault();
  $(".question-table-content").toggle(300);
});

$(".feedback-link").click(function(event){
  event.preventDefault();
  $(".feedback-table-content").toggle(300);
});

});
