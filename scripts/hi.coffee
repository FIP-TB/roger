# Description:
#   Roger est poli.
#
# Notes:
#

module.exports = (robot) ->
        enterReplies = ['Hello', 'Salut', 'Salut les mecs']
        leaveReplies = ['a+']

        robot.enter (res) ->
                res.send res.random enterReplies

        robot.leave (res) ->
          res.send res.random leaveReplies
