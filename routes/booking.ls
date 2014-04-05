exports.index = (req, res) ->
  res.render 'booking', title: 'Book a site', url: req.path
