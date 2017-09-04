### Sencillo...

Crea un correo de mailgun y entrégalo a través de la API.

```ruby
require 'mailgun'
MailGun.apikey='key-asdffoobar9asdodafjosfkasdh'
MailGun.domain='tudominio.com'
mail=MailGun.new
mail.text='hola mundo'
mail.html='<p>hola mundo</p>'
mail.reply_to='noreply@dominio.com'
mail.from='fulano@tudominio.com'
mail.to='siclano@gmail.com'
mail.subject='tal cosa'
mail.send
```

Se aceptan donaciones [14iNmkfULf5jggumVh963kUg4UPScEZHgz](https://blockchain.info/address/14iNmkfULf5jggumVh963kUg4UPScEZHgz)

<br>

#### Veámoslo en cámara lenta

### Clave y Dominio

MailGun requiere una clave de la API y un dominio. Si no quieres escribirlo tanto, entonces puedes establecerlo de manera global en la configuración. Luego, cada objeto mail que crées ya tendrá establecido ese dominio y clave.

```ruby

# setea la configuración de mailgun a nivel global
MailGun.apikey='key-asdffoobar9asdodafjosfkasdh'
MailGun.domain='tudominio.com'

# crea un nuevo correo
mail=MailGun.new

# veamos que dominio de mailgun usa
mail.dominio # => "tudominio.com"
mail.domain # => "tudominio.com" (pa los angloparlantes)
mail.dom    # => "tudominio.com" (pa los vagos)

# veamos que clave de mailgun usa
mail.apikey # => "key-asdffoobar9asdodafjosfkasdh"
```

Si usas múltiples dominios, puede setearle a cada correo su dominio y clave individualmente

```ruby
mail=MailGun.new
mail.apikey='key-asdffoobar9asdodafjosfkasdh'
mail.domain='tudominio.com'
```

### Correo multiparte

Si usas mensajes multiparte, debes tener **html** y **text** bien declarados. Si solamente quiere hacer mensajes de texto plano, setea el **body**.


```ruby

# esto es un correo de texto plano
# usa el «body»
mail=MailGun.new
mail.body='hola mundo'
mail.from='fulano@tudominio.com'
mail.to='siclano@gmail.com'
mail.subject='este correo es texto plano'
mail.deliver # lo mismo que «send»

# este es un correo multiparte
# usa «text» y «html»
mail=MailGun.new
mail.text='hola mundo'
mail.html='<p>hola mundo</p>'
mail.from='fulano@tudominio.com'
mail.to='siclano@gmail.com'
mail.subject='este correo es multiparte'
mail.enviar # lo mismo que «deliver»

# para saber que tipo de correo es
mail.tipo # => :multiparte


```

Un correo que tenga **html**, **text** y además **body**, dará error.

### El correo

Puedes ir como va quedando el correo que irá a mailgun.

```ruby
mail.to_h # devuelve el corre como hash
mail.to_json # como json
mail.pretty_generate # como json "jiuman rídabl"
mail.from # muestra el From: del correo
mail.subject # muestra el Subject: del correo
```

### Reply-To

Muy importante, cambiar el Reply-To (mucha gente lo entiende necesario).

```ruby
mail.reply_to='otra@direccion.com'
```

### instalación

Haste un Gemfile y ponle

```ruby
gem 'mailgun', git: 'https://github.com/uranio-235/mailgun.git'
```

Se aceptan donaciones [14iNmkfULf5jggumVh963kUg4UPScEZHgz](https://blockchain.info/address/14iNmkfULf5jggumVh963kUg4UPScEZHgz)
