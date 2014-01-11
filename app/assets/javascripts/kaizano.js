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

$(document).ready(function() {
  $('.new_question_vote').on('submit', function(event) {
    event.preventDefault();
    $form = $(event.currentTarget);
    $count = $form.find('.count');
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      dataType: "json",
      success: function() {
        $convertToInteger = parseFloat(($count.text()));
        $updatedCount = ($convertToInteger + 1)
        $count.text($updatedCount);

        sortQuestions();
      }
    });
  });
});

  var sortQuestions = function() {
    $('.question-object').sort(function (a, b) {
      return ($(b).find('.count').text() + $(a).index()) - ($(a).find('.count').text() + $(b).index());
    }).appendTo('.question-feed');
  }