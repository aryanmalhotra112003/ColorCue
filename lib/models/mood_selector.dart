String moodSelector(int taskCount) {
  if (taskCount >= 0 && taskCount <= 5) {
    return 'assets/animations/corgi_chill.json'; // 💤 relaxed
  } else if (taskCount > 5 && taskCount <= 10) {
    return 'assets/animations/corgi_smile.json'; // 😊 smiley
  } else if (taskCount > 10 && taskCount <= 15) {
    return 'assets/animations/corgi_sipping.json'; // ☕ calm & sipping
  } else if (taskCount > 15 && taskCount <= 20) {
    return 'assets/animations/corgi_typing.json'; // ⌨️ focused
  } else if (taskCount > 20 && taskCount <= 25) {
    return 'assets/animations/corgi_thinking.json'; // 🤔 puzzled
  } else if (taskCount > 25 && taskCount <= 30) {
    return 'assets/animations/corgi_alert.json'; // ⚠️ alert
  } else if (taskCount > 30 && taskCount <= 35) {
    return 'assets/animations/corgi_worried.json'; // 😰 worried
  } else if (taskCount > 35 && taskCount <= 40) {
    return 'assets/animations/corgi_panic.json'; // 😱 panicking
  } else if (taskCount > 40 && taskCount <= 50) {
    return 'assets/animations/corgi_scream.json'; // 😵 scream
  } else if (taskCount > 50 && taskCount <= 65) {
    return 'assets/animations/corgi_glitching.json'; // 🌀 glitchy
  } else if (taskCount > 65 && taskCount <= 80) {
    return 'assets/animations/corgi_loopy.json'; // 🔁 going loopy
  } else {
    return 'assets/animations/corgi_dead_inside.json'; // ☠️ max overload
  }
}
