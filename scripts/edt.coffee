# Description:
#   Roger aime les cours.
#
# Notes:
#

request = require 'request'
moment = require 'moment'
ical = require 'ical.js'

SCHEDULES_URL = 'https://portail.telecom-bretagne.eu/portal/pls/portal/DATA_REF.PAK_ICAL.EDT_ELEVE?cle=44DD599E3E1EFFCD'

schedules = []

module.exports = (robot) ->
        robot.respond /on aura quoi demain/i, (res) ->
                res.send schedulesFor moment().add(1, 'days')

schedulesFor = (date) ->
        output = 'Alors, on aura '
        
        for schedule in schedules
                if date.isSame(schedule.startDate, 'day')
                        output += "#{ schedule.summary } / "

        output += 'Bon courage !'
        
        return output

parseSchedules = (jcal) ->
        events = jcal[1][2]
        
        for event in events
                schedules.push {
                'startDate': event[1][1][3],
                'endDate':   event[1][2][3],
                'summary':   event[1][3][3]
                }

downloadSchedules = ->
        request SCHEDULES_URL, (error, response, body) ->
                parseSchedules ICAL.parse(body)
                

downloadSchedules()
