import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  	debugger
  	var micropost_id = data.micropost_id;
  	$('#append-comment'+micropost_id).append('<p style = "padding-left:50px">'+'<b>'+data.username+'</b>:'+data.content+'</p>')
  	// Called when there's incoming data on the websocket for this channel
  }
});
