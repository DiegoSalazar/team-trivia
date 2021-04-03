import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create('TeamMessagesChannel', {
  connected() {
    console.log('TeamMessagesChannel#connect') // debug
    this.scrollChatDown()

    document.addEventListener('team-message', this.scrollChatDown.bind(this))
    document.addEventListener('turbolinks:load', this.scrollChatDown.bind(this))
  },

  disconnected() {
    document.removeEventListener('team-message', this.scrollChatDown.bind(this))
    document.removeEventListener('turbolinks:load', this.scrollChatDown.bind(this))
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
