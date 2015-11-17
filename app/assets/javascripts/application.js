//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets



function runAutoRefresh(token, csfr) {
  // Connect to Socky Server
  var socky = new Socky.Client('ws://localhost:3001/websocket/todo');
  
  // Bind message after connecting to server
  socky.bind("socky:connection:established", function() {
    console.log("Connected");
  });
  
  // Bind message after disconnecting from server
  socky.bind("socky:connection:closed", function() {
    console.log("Connection closed");
  });

  // Subscribe to channel
  // You can subscribe to as much channels as you want
  // { write:true } option will allow sending messages directly to server
  //   note: this will require enabling this in authenticator
  // { data: { login: username } } all 'data' options are passed to other users
  var channel = socky.subscribe(token, { write: true });
  
  // Bind message after successfull joining channel
  channel.bind("socky:subscribe:success", function(members) {
    console.log("Joined channel");
  });
  
  // Bind function to 'chat_message' event
  // This event can be sent by all clients with 'write' permission
  channel.bind("reload", function(message) {
    if (message.token == token) {
      location.reload();
    }
  });
  
  // jQuery bind sending message via form to channel event
  $("#add_todo").submit(function(e) {
    e.preventDefault();
    channel.trigger("reload", { token: token });
    $('#message').val('')
    return false;
  });
};
