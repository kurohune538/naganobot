# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
cronJob = require('cron').CronJob

module.exports = (robot) ->
  cronjob = new cronJob('0 55 9 * * 4-5', () =>
    envelope = room: "#general"
    robot.send envelope, "@all:もうすぐゼミ始まるっぽいです"
  )
  cronjob.start()

  robot.hear /自己紹介/i, (msg) ->
    msg.send "これもう勝負始まってんな"

  robot.respond /夢/i, (msg) ->
    msg.send "@#{msg.message.user.name}夢は27歳の時に本田翼と結婚することです"

  robot.hear /かわいい|可愛い/i, (msg) ->
    timestamp = (new Date()).toISOString().replace(/[^0-9]/g, "")
    msg.send "#{msg.message.user.name}ばっさー可愛いですよね"
    msg.send "http://pisukisu.com/wp-content/uploads/2015/04/c9aa3e92f85fdf0d1fe5cbedfcb5522e.jpg?#{timestamp}"

  robot.hear /@naganobot/i, (msg) ->
    goroku = [
      "ばっさー以外の彼女作る気無いんで話しかけないでください",
      "僕ポテンシャルしかないんですよ",
      "上裸の写真iPhoneにあります",
      "最近は衝動に任せて走るんです",
      "どうも",
      "僕黙ってればモテるんで"
    ]
    toUser = "@#{msg.message.user.name}:"
    selectedMessage = msg.random goroku
    msg.send "#{toUser} #{selectedMessage}"

  robot.hear /今日のランチ/i, (msg) ->
    #自炊参加メンバー
    member = [
      "@shinnosuke",
      "@taiga",
      "@kahojapan",
      "@shiori_k"
    ]
    #炊飯当番を決める
    suihanNum = Math.floor(Math.random() * member.length)
    selectedSuihan = member[suihanNum]
    member.splice(suihanNum, 1)
    #洗い物当番を決める
    araimonoNum = Math.floor(Math.random() * member.length)
    selectedAraimono = member[araimonoNum]
    msg.send "今日の炊飯は #{selectedSuihan}: で洗い物は #{selectedAraimono}: がやれ"
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  enterReplies = ['どうも', 'よろしくお願いします', 'おはようございますみなさん', '長野です', 'あ、長野です']
  leaveReplies = ['では', 'お疲れ様です', 'さようなら']

  robot.enter (res) ->
    res.send res.random enterReplies
  robot.leave (res) ->
    res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
