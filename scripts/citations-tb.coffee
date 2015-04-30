# Description:
#  Citations aléatoires et filtrées.
#
# Notes:
#  Les citations doivent êtres dans le premier fichier passé en paramètre de `initializeQuotes`. Une ligne par citation.
#  Les mots interdits doivent êtres dans le second fichier passé en paramètre de `initializeQuotes`. Une ligne par mot.

fs = require 'fs'
cleanQuotes = []

module.exports = (robot) ->

  robot.respond /citation/i, (res) ->
    quoteNumber = Math.floor(Math.random() * cleanQuotes.length)
    res.send cleanQuotes[quoteNumber]

initializeQuotes = (quotesFile, blacklistFile) ->
  # Read quotes from file
  fs.readFile quotesFile, 'utf8', (err, quotes) ->
    throw err if err

    # Read blacklisted words from file
    fs.readFile blacklistFile, 'utf8', (err, blacklist) ->
      throw err if err

      # Filter quotes
      filterQuotes(quotes, blacklist)

filterQuotes = (quotes, blacklist) ->
  words = blacklist.split('\n')
  
  for word in words
    continue if word.trim() == ''
    regex = new RegExp word, 'gim' # Ignore case
    quotes = quotes.replace regex, '****'

  cleanQuotes = quotes.split('\n')

initializeQuotes('./citations.txt', './blacklist.txt')
