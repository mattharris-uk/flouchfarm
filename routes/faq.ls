exports.index = (req, res) ->
  res.render 'faq', title: 'Frequently asked questions', url: req.path
