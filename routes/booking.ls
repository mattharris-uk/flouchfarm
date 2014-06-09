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
      * type: 'parking1'
        singular: 'parking space'
        plural: 'parking spaces'
        detail: 'on Sunday 6th July'
        description: '1 parking space on Sunday 6th July'
        price: 10
      * type: 'camping1'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 1 night (Friday 4th July)'
        description: '1 camping pitch for 1 night (Friday 4th July)'
        price: 70
      * type: 'camping2'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 1 night (Saturday 5th July)'
        description: '1 camping pitch for 1 night (Saturday 5th July)'
        price: 70
      * type: 'camping3'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 1 night (Sunday 6th July)'
        description: '1 camping pitch for 1 night (Sunday 6th July)'
        price: 70
      * type: 'camping4'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 2 nights (Friday 4th July to Saturday 5th July)'
        description: '1 camping pitch for 2 nights (Friday 4th July to Saturday 5th July)'
        price: 100
      * type: 'camping5'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 2 nights (Saturday 5th July to Sunday 6th July)'
        description: '1 camping pitch for 2 nights (Saturday 5th July to Sunday 6th July)'
        price: 100
      * type: 'camping6'
        singular: 'camping pitch'
        plural: 'camping pitches'
        detail: 'for 3 nights (Friday 4th July to Sunday 6th July)'
        description: '1 camping pitch for 3 nights (Friday 4th July to Sunday 6th July)'
        price: 125

exports.charge = (req, res) ->
  bluebird.resolve stripe.charges.create do
    amount: (req.body['parking1-qty'] - 0) * 1000p + (req.body['camping1'] - 0) * 7000p + (req.body['camping2-qty'] - 0) * 7000p + (req.body['camping3-qty'] - 0) * 7000p + (req.body['camping4-qty'] - 0) * 10000p + (req.body['camping5-qty'] - 0) * 10000p + (req.body['camping6-qty'] - 0) * 12500p
    currency: 'GBP'
    card: req.body.token
    description: JSON.stringify req.body
  .then ->
    res.redirect '/booking/thanks'
    it.preventDefault();
  .catch ->
    console.log JSON.stringify it
    res.redirect '/booking/error'
    it.preventDefault();


exports.thanks = (req, res) ->
  res.render 'booking/thanks'

exports.declined = (req, res) ->
  res.render 'booking/declined'

exports.error = (req, res) ->
  res.render 'booking/error'
