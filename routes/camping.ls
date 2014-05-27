exports.index = (req, res) ->
  res.render 'camping', title: 'Camping at Flouch Farm', url: req.path
