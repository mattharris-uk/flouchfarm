exports.index = (req, res) ->
  res.render 'index', title: 'Flouch Farm', url: req.path
