# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

request = require 'request'

menus = []

request 'http://minirak.maxmouchet.com/menus.json', (error, response, body) ->
        menus = JSON.parse(body)

today = new Date()
year = today.getFullYear()
month = today.getMonth() + 1
month = "0#{ month }" if month < 10
day = today.getDate()
day = "0#{ day }" if day < 10

todayString = "#{ year }-#{ month }-#{ day }"

module.exports = (robot) ->
        robot.hear /rak/i, (res) ->
                res.send getRAKMenu()

        robot.respond /on mange quoi ce soir/i, (res) ->
                res.reply getRAKMenu()

getRAKMenu = ->
        for menu in menus
                if menu.date == todayString
                        output = ""
                        for meal in menu.meals
                                if meal.time == 'lunch'
                                        output += "Ce midi, on mangera: "
                                else output += "\nEt ce soir, on mangera: "
                                for course in meal.courses
                                        output += "#{ dish } " for dish in course.dishes
                                                
                        output += "\nBon Ap' mi amigos !"
                        return output
