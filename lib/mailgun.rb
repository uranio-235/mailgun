# hablaremos con la APi
require 'rest-client' unless defined? RestClient
require 'json' unless defined? JSON
require 'ostruct' unless defined? OpenStruct


class MailGun

    def self.apikey=que
        @@apikey=que
    end

    def self.dom= cual
        @@dominio=cual
    end
    def self.dominio= cual
        @@dominio=cual
    end
    def self.domain= cual
        @@dominio=cual
    end

    # los elementos del correo, oblgiado y opcionales
    attr_accessor :from, :to ,:subject, :text, :html, :body, :reply_to, :x_mailer, :apikey, :dominio

    # dominio para los angloparlantes compatible con angloparlantes
    alias dom dominio
    alias domain dominio

    def initialize

        # aquí meteremos el correo para mailgun
        @@correo={}

        # por definición, no es un tipo de correo (monoparte o multiparte)
        @@tipo=nil

        # si la clave de la API y el dominio están en constantes, setealos a la instancia
        @apikey=@@apikey if defined? @@apikey
        @dominio=@@dominio if defined? @@dominio

    end # initialize

    # verificar
    def verificar

        # la apikey es imprescindible
        raise ArgumentError,'mailgun no funciona sin una APIkey' unless @apikey.is_a? String

        # cual es el dominio de mailgun
        raise ArgumentError,'debe especificar el dominio' unless @dominio.is_a? String

        # el to debe estar presente y ser un array o string
        raise ArgumentError,"el «to» debe ser un String o Array" unless @to.is_a? String or @to.is_a? Array

        # el asunto debe estar presente y decente
        raise ArgumentError,"el «subject» debe ser algo decente" unless @subject.is_a? String and @subject.length>2

        # el correo debe tener un from y debe ser del dominio de chipojosoft
        raise ArgumentError,'el «from» es imprecindible en un correo' unless @from.is_a? String
        raise ArgumentError,"el «from» debe ser una dirección del dominio #{@dominio}" unless @from.include? "@#{@dominio}"

        # el mensaje multiparte, usa text y html
        if @text.is_a? String and @html and @body.nil?
            @@tipo = :multiparte
        elsif @body.is_a? String and @text.nil? and @html.nil?  # los planos, usan body
            @@tipo = :plain
        else
            # si no especificó un tipo, o sea, si no conformó bien el cuerpo del correo, suspenso
            raise ArgumentError,"los mensajes usan :body solo, o :text + :html si son multiparte"
        end


        # si todo está bien, dale true
        return true

    end # verificar

    # está listo el correo
    def listo?
        verificar rescue false
    end

    alias ready? listo?

    # enviar correo
    def correo

        # el asunto
        @@correo['subject']=@subject

        # el destino
        @@correo['to']=@to

        # el origen
        @@correo['from']=@from

        # si tiene reply_to y además es válido, inclúyelo
        @@correo['h:Reply-To']=@reply_to if @reply_to and @reply_to.include? '@'

        # que MUA se empleo
        if @x_mailer
            @@correo['h:X-Mailer']=@x_mailer
        else
            @@correo['h:X-Mailer']=RUBY_DESCRIPTION
        end

        # el cuerpo del mensaje varía según el tipo
        if @@tipo==:multiparte
            @@correo['text']=@text
            @@correo['html']=@html
        else
            @@correo['body']=@body
        end

        # devuelve el correo
        return @@correo

    end # correo

    alias mail correo
    alias to_h correo


    # devuelve un json
    def to_json
        correo
        @@correo.to_json
    end

    # devuelve un json bonitillo
    def pretty_generate
        correo
        JSON.pretty_generate @@correo
    end

    # devuelve un el tipo de correo
    def tipo
        verificar
        return @@tipo
    end
    alias type tipo


    # método para enviar el correo
    def enviar

        # tírame el correo plis
        verificar
        correo

            # cuantas veces lo intentamos
            @re=4

            begin

                # tírala!
                @respuesta=RestClient.post "https://api:#{@apikey}@api.mailgun.net/v3/#{@dominio}/messages",@@correo

                # dime que te cuenta mailgun
                return JSON.parse(@respuesta.body)

                # "#{@respuesta['id']} #{@respuesta['message']}"

            rescue

                # si quedan reintentos
                if @re>0
                    sleep(1)
                    @re=@re-1
                    retry
                end

                # si no, chilla
                warn 'Palo irremediable con mailgun...'
                raise Exception,$!

            end # begin

        end # enviar

        # puede que quizás te guste
        alias deliver enviar
        alias send enviar

end # MailGun
