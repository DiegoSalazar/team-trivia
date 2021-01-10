import CableReady from 'cable_ready'
import consumer from "./consumer"

consumer.subscriptions.create("SubmissionChannel", {
  received(data) {
    if (data.cableReady) {
      console.debug('SubmissionChannel received:', { data }) // debug
      CableReady.perform(data.operations)
    }
  }
});
