require! <[
  bluebird
  stripe
]>

stripe = stripe process.env.stripe_key

exports.index = (req, res) ->
  res.render 'booking/book' do
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
  amount = (req.body['parking-qty'] - 0) * 1000p + (req.body['camping-qty'] - 0) * 15000p
  bluebird.resolve stripe.charges.create do
    amount: amount
    currency: 'GBP'
    card: req.body.token
    description: JSON.stringify req.body
  .then ->
    res.redirect '/booking/thanks'
  .catch ->
    console.log JSON.stringify it
    res.redirect '/booking/error'

exports.thanks = (req, res) ->
  res.render 'booking/thanks'

exports.declined = (req, res) ->
  res.render 'booking/declined'

exports.error = (req, res) ->
  res.render 'booking/error'
