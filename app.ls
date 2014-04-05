require! <[
  ./routes
  express
  http
  path
]>

app = express!

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

app.use express.errorHandler! if 'development' is app.get 'env'

app.get '/', routes.home.index
app.get '/about', routes.about.index
app.get '/booking', routes.booking.index
app.get '/contact-us', routes.contact.index
app.get '/faq', routes.faq.index

http.createServer app .listen (app.get 'port'), ->
  console.log "Express server listening on port #{app.get 'port'}"