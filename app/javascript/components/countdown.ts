export default class Countdown {
  el: Element
  startTimeMs: number
  intervalId: number | NodeJS.Timeout
  onEnded: Function

  constructor (el: Element, startTime: Date) {
    this.el = el
    this.startTimeMs = startTime.getTime()
    this.onEnded = () => {}
  }

  startCountdown () {
    this.updateClock()
    this.intervalId = setInterval(() => this.updateClock(), 1000)
  }

  stopCountdown () {
    clearInterval(<NodeJS.Timeout>this.intervalId)
  }

  updateClock () {
    const { days, hours, minutes, seconds } = this.calcCountdown()
    this.el.innerHTML = this.newClock(days, hours, minutes, seconds)

    if (this.ended(days, hours, minutes, seconds)) {
      this.stopCountdown()
      this.onEnded()
    }
  }

  ended (days: number, hours: number, minutes: number, seconds: number) {
    return [days, hours, minutes, seconds].every(t => t <= 0)
  }

  newClock (days, hours, minutes, seconds) {
    let html = ''

    if (days) html += `<div>${this.timeLabel(days, 'd')}</div>`
    if (hours) html += `<div>${this.timeLabel(hours, 'h')}</div>`
    html += `<span>${this.timeLabel(this.zeroPad(minutes), 'm')}</span>`
    html += `<span>${this.timeLabel(this.zeroPad(seconds), 's')}</span>`

    return html
  }

  calcCountdown () {
    const now = new Date().getTime()
    const diff = this.startTimeMs - now
    const sec = 1000
    const min = sec * 60
    const hour = min * 60
    const day = hour * 24
    const days = Math.floor(diff / day)
    const hours = Math.floor(diff % day / hour)
    const minutes = Math.floor(diff % hour / min)
    const seconds = Math.floor(diff % min / sec)
    return { days, hours, minutes, seconds }
  }

  timeLabel (time: number | string, label: string) {
    return `<strong>${time}</strong><small>${label}</small>`
  }

  zeroPad (n: number) {
    return n < 10 && n > -1 ? `0${n}` : n.toString()
  }
}
