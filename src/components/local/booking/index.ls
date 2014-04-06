window <<< require \prelude-ls

module.exports = (selector) ->
  $form = $ selector

  handler = StripeCheckout.configure do
    key: 'pk_test_ksQy2DtmLvSzFogm10ZlccRT'
    image: '/images/IMG_3866_2.jpg'
    token: (token, args) ->
      $ '<input />'
      .attr 'type', 'hidden'
      .attr 'name', 'token'
      .attr 'value', token.id
      .appendTo $form
      $form.submit!

  data = {}
  $ '.pay-now button' .click ->
    desc = []
    amount = 0;
    for key, val of data
      desc.push val.desc
      amount += val.total
    email = $form.find 'input[name="email"]' .val!
    handler.open do
      name: 'Flouch Farm'
      description: desc * ' & '
      amount: amount
      currency: 'GBP'
      email: email
    it.preventDefault();

  $form.find 'input' |> each ->
    name = $ it .attr 'name'
    if name
      split = name / '-'
      if split.1 is 'qty'
        sku = split.0
        $qty = $ it
        $group = $qty.closest '.form-group'
        $total = $group.find ".#{sku}-total"
        $qty.on 'change paste keyup' ->
          qty = $qty.val! - 0
          if qty < 0
            $qty.val 0
          else
            price = $total.attr 'data-price'
            sub-total = qty * price * 100
            display-amount = "£#{sub-total / 100}"
            $total.text display-amount
            data[sku] =
              desc: "#qty #sku"
              qty: qty
              total: sub-total
