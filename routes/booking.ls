exports.index = (req, res) ->
  res.render 'booking' do
    title: 'Booking'
    url: req.path
    items:
      * type: 'parking'
        singular: 'parking space'
        plural: 'parking spaces'
        detail: 'on Sunday 6th July'
        price: 10
      * type: 'camping'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 3 nights (Friday, 4th July to Sunday, 6th July)'
        price: 150

exports.charge = (req, res) ->
  console.log req.body
  res.redirect '/booking/thanks'

exports.thanks = (req, res) ->
  res.render 'thanks'
