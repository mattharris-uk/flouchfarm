exports.index = (req, res) ->
  res.render 'about', title: 'About Flouch Farm', url: req.path
