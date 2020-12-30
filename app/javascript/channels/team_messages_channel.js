import CableReady from "cable_ready";
import consumer from "./consumer"

consumer.subscriptions.create("TeamMessagesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.cableReady) {
      CableReady.perform(data.operations)

      const messages = document.getElementById('team_messages')
      console.debug({ channel: 'team_messages', messages }) // debug
      if (messages) messages.scrollTop = messages.scrollHeight
    }
  }
});
