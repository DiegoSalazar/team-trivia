import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create('TeamMessagesChannel', {
  connected() {
    this.scrollChatDown()

    document.addEventListener('team-message', () => {
      this.scrollChatDown()
    })
  },

  disconnected() {},

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
