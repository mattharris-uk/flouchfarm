global <<< require 'prelude-ls'

module.exports =
  <[home about booking faq contact]> |>
  map (-> [it, require "./#it"]) |> pairs-to-obj
