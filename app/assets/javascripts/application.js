//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets

function runAutoRefresh(token) {
  // Connect to Socky Server
  var socky = new Socky.Client('ws://pacific-mesa-9385.herokuapp.com:80/websocket/todo');
  

  // Subscribe to channel
  // You can subscribe to as much channels as you want
  // { write:true } option will allow sending messages directly to server
  //   note: this will require enabling this in authenticator
  // { data: { login: username } } all 'data' options are passed to other users

  // TODO: too long strings won't work
  var channelString = "presence-".concat(token.substring(0, 6));
  var channel = socky.subscribe(channelString, { write: true , data: { } });
 
  // Bind message after successfull joining channel
  channel.bind("socky:subscribe:success", function(members) {
    console.log("Joined channel");
  });
  
  // Bind function to 'chat_message' event
  // This event can be sent by all clients with 'write' permission
  channel.bind("reload", function(message) {
    location.reload();
  });
};

// function updateAutoRefresh(token) {
  // // Connect to Socky Server
  // var socky = new Socky.Client('ws://localhost:3001/websocket/todo');

  // var channelString = "presence-".concat(token.substring(0, 6));
  // var channel = socky.subscribe(channelString, { write: true , data: { } });
  
  // channel.bind("socky:subscribe:success", function(members) {
    // console.log("Joined channel");
  // });
  
  // // jQuery bind sending message via form to channel event
  // $("#add_todo").click(function(e) {
    // e.preventDefault();
    // channel.trigger("reload");
    // return false;
  // });
// };
