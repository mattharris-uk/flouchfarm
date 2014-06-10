window <<< require \prelude-ls

module.exports = (selector) ->
  $form = $ selector

  handler = StripeCheckout.configure do
    key: 'pk_live_MMevxvlb7tBFdbyZoTmSR3i6'
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
    first = $form.find 'input[name="first-name"]' .val!
    last = $form.find 'input[name="last-name"]' .val!
    phone = $form.find 'input[name="phone"]' .val!
    registration = $form.find 'input[name="registration"]' .val!
    email = $form.find 'input[name="email"]' .val!
    if first == ""
      alert("Please enter a first name")
      it.preventDefault();
      return
    if last == ""
      alert("Please enter a surname")
      it.preventDefault();
      return
    if phone == ""
      alert("Please enter a contact phone number")
      it.preventDefault();
      return
    if email == ""
      alert("Please enter an email address")
      it.preventDefault();
      return
    if reg == ""
      alert('Please enter one or more vehicle registration numbers')
      it.preventDefault();
      return
    desc = []
    amount = 0;
    for key, val of data
      desc.push val.desc
      amount += val.total

    if amount == 0
      alert("Please select a reservation")
      it.preventDefault();
      return

    reg = $form.find 'input[name="registration"]' .val!
    str = (desc * ' Registration-- ') + ' Registration: ' + reg

    handler.open do
      name: 'flouchfarm.co.uk'
      description: 'Le Tour camping/parking booking'
      amount: amount
      currency: 'gbp'
      email: email
    it.preventDefault();

  $form.find 'input' |> each ->
    desc = $ it .attr 'placeholder'
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
            if qty == 0
              delete data[desc];

            if qty != 0
              data[desc] =
                desc: "#desc"
                qty: qty
                total: sub-total
