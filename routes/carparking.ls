exports.index = (req, res) ->
  res.render 'carparking', title: 'Car Parking at Flouch Farm', url: req.path