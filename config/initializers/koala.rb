# In Rails, you could put this in config/initializers/koala.rb
$tok_grph = "EAACEdEose0cBALBcvl2naREV9ZAzJ4ZB0kW6JfUu9fEiuiVZAZAcUFgd0F64E4bRGW93yZCNKKSYEatP9sTDizq4CbN7qVDC30C9GIwn0J78hkmMFCN1XxMOM3oFgJxbfxFXksZC8ZBGU3FitSwuOhWf8tZBwdUtPpa6cKZBDl1lUuY6ZBJ7ZCcRhDvFHYx9leQcLqyo2DLUdZCO6gZDZD"
$tok_tienda = "EAAUJuPkcQtkBAAaM9R5q2YZAmSFXeJDh5NMZBskyZBdXiahvOmj54j6ryDWybVJlBUb75avyM4aJ4x2vUiCtZAF4vAOV9OclIK6ZACPOKTbcUMNMdkGrc7s8av8g6VoHCebU3ArjUlYtyfZCZBEm3eRjZBDcUpKvfd86qh7nj0N3UgZDZD"
$tok_wede = "EAACEdEose0cBAPaT6p1B9mbc2knD96qFgfH5ygowMMEXFZCtPN7RGX9h4EWOO772qgiJhBKlZCgCyQK1cshHAB7YajDh7Nz2lwGTzcJLuPH3h0AEZCInIqAFISEwuyWgrwWjxIcJJvtQOuUNnLnZAhK6NZBUsI0BSuHx0ZCZCUwbwZCZCro1z0sI2j6YTMEjWO8OeaxSgv3PhkAZDZD"
Koala.configure do |config|
  config.access_token = $tok_tienda
  #
  #config.app_access_token = "1418064941564633|XakQ7kkZM6Bhfwhdev7wIlBJomU"
  #config.app_id = "1418064941564633"
  #config.app_secret = "237906634f56b6eb6d6118213370c355"
  config.graph_server = 'graph.facebook.com'
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end