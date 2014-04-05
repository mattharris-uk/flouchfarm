require! <[
  ./routes
  express
  http
  path
]>

app = express!
is-dev = 'development' is app.get 'env'

app.set 'port' process.env.PORT || 3000
app.set 'views' path.join __dirname, 'views'
app.set 'view engine' 'jade'
app.use express.favicon!
app.use express.logger 'dev'
app.use express.json!
app.use express.urlencoded!
app.use express.methodOverride!
app.use app.router
app.use express.static path.join __dirname, 'public'

if is-dev
  app.use express.errorHandler!
  app.locals.pretty = true

app.get '/' routes.home.index
app.get '/about' routes.about.index
app.get '/contact-us' routes.contact.index
app.get '/faq' routes.faq.index

app.get '/booking' routes.booking.index
app.post '/booking/charge' routes.booking.charge
app.get '/booking/thanks' routes.booking.thanks

http.createServer app .listen (app.get 'port'), ->
  console.log "Express server listening on port #{app.get 'port'}"
