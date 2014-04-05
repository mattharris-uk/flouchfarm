exports.index = (req, res) ->
  res.render 'contact-us', title: 'Contact Flouch Farm', url: req.path
