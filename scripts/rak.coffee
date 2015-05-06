# Description:
#   Les menus du RAK.
#
# Notes:
#

request = require 'request'
moment = require 'moment'

menus = []

module.exports = (robot) ->
        robot.respond /on mange quoi$/i, (res) ->
                res.send getMenuFor moment()
        
        robot.respond /on mange quoi demain/i, (res) ->
                res.send getMenuFor moment().add(1, 'days')

        robot.respond /rak update/i, (res) ->
                res.send 'Je vais mettre à jour les menus du RAK.'
                downloadMenus()

getMenuFor = (date) ->
        dateString = date.format('YYYY-MM-DD')
        dayString = date.startOf('day').add(12, 'hours').locale('fr').calendar()
        
        for menu in menus
                if menu.date == dateString
                        output = ""
                        for meal in menu.meals
                                if meal.time == 'lunch'
                                        output += "#{ dayString } on mangera: "
                                else output += "et le soir on mangera: "
                                for course in meal.courses
                                        output += "#{ dish }, " for dish in course.dishes
                                                
                        output += "Bon Ap' !"
                        return output

downloadMenus = ->
        request 'http://minirak.maxmouchet.com/menus.json', (error, response, body) ->
                menus = JSON.parse(body)

# Update menus on start
downloadMenus()
