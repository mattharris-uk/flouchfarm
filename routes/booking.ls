exports.index = (req, res) ->
  res.render 'booking', title: 'Booking', url: req.path
