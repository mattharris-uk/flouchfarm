global <<< require 'prelude-ls'

module.exports =
  <[home camping carparking booking faq contact]> |>
  map (-> [it, require "./#it"]) |> pairs-to-obj

exports.moreinfo = (req, res) ->
  res.render '/camping'
  
exports.booknow = (req, res) ->
  res.render '/booking'