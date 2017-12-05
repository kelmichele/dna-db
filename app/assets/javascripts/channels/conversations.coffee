App.conversations = App.cable.subscriptions.create "ConversationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	jQuery(document).on 'turbolinks:load', ->
  	  messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
  	  messages = $('#conversation-body')

  	  if messages.length > 0
  	    messages_to_bottom()
    # Called when there's incoming data on the websocket for this channel
