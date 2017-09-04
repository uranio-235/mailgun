# autogeneramos la version a patitir de los commit de git
commit=File.read('.git/logs/HEAD').lines.to_a.length
version=(commit*0.1).round(1)

# la gema
Gem::Specification.new do |s|

    s.files       = %w[lib/mailgun.rb README.md]
    s.name        = 'mailgun'
    s.version     = version
    s.date        = Time.now.to_s.split(' ')[0]
    s.summary     = 'helper de mailgun'
    s.description = 'correos de mailgun al momento'
    s.authors     = 'Uranio-235'
    s.email       = 'rubygem@chipojosoft.com'
    s.homepage    = 'http://github.com/uranio-235/mailgun'
    s.licenses    = ['MIT']
    s.required_ruby_version = '~> 2.0'
    s.add_runtime_dependency 'rest-client' , ['~> 2']

end #  Gem::Specification
