export default class Countdown {
  startTimeMs: number
  el: Element
  intervalId: number | NodeJS.Timeout

  constructor (startTime: Date, el: Element) {
    this.startTimeMs = startTime.getTime()
    this.el = el
  }

  startCountdown () {
    this.updateClock()
    this.intervalId = setInterval(() => this.updateClock(), 1000)
  }

  stopCountdown () {
    clearInterval(<NodeJS.Timeout>this.intervalId)
  }

  updateClock () {
    this.el.innerHTML = this.newClock()
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

  newClock () {
    const { days, hours, minutes, seconds } = this.calcCountdown()
    const parts = []

    if (days) parts.push(this.timeLabel(days, 'd'))
    if (hours) parts.push(this.timeLabel(hours, 'h'))
    parts.push(this.timeLabel(this.zeroPad(minutes), 'm'))
    parts.push(this.timeLabel(this.zeroPad(seconds), 's'))

    return parts.join('')
  }

  timeLabel (time: number | string, label: string) {
    return `<strong>${time}</strong><small>${label}</small>`
  }

  zeroPad (n: number) {
    return n < 10 && n > -1 ? `0${n}` : n.toString()
  }
}
