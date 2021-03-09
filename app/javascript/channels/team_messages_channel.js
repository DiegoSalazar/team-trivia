import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create('TeamMessagesChannel', {
  // Called when the subscription is ready for use on the server
  connected() {
    this.scrollChatDown()

    document.addEventListener('new-team-message', () => {
      this.scrollChatDown()
    })
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received (data) {
    if (data.cableReady) {
      console.debug('TeamMessagesChannel received:', { data }) // debug
      CableReady.perform(data.operations)
    }
  },

  scrollChatDown () {
    const messages = document.getElementById('team_messages')
    if (messages) messages.scrollTop = messages.scrollHeight
  }
});
