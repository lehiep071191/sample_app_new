$(document).on('turbolinks:load', function(){
	$('.post-comment').on('click', function(){
		var micropost_id = $(this).data('id');
		$.ajax({
			url: '/comments',
			type: 'post',
			dataType: 'json',
			data: {
				content: $('#comment-content'+micropost_id).val(),
				user_id: $('#comment-user'+micropost_id).val(),
				micropost_id: micropost_id
			},
			success: function(data){
				$('#append-comment'+micropost_id).append(data.data_comment);
			}
		})
	})
})