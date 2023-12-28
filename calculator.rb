require 'date'
require 'pry'

module Calculator

  def self.amounts api_response, document_amount, expiration_date, fecha_formulario
    #Variables
    document_rate = (api_response["document_rate"] / 100)
    commission = api_response["commission"]
    advance_percent = (api_response["advance_percent"] / 100)
    diferencia_dias = dias_corridos_desde(fecha_formulario, expiration_date)
    #Calculos
    costo = (document_amount * advance_percent) * ((document_rate/100) / 30 * diferencia_dias)
    giro = (document_amount * advance_percent) - (costo + commission)
    excedente =  (document_amount - (document_amount * advance_percent))
    #Formateos
    monto_costo = format_number_with_delimiter(costo)
    monto_giro = format_number_with_delimiter(giro)
    monto_excedente = format_number_with_delimiter(excedente)
    [monto_costo, monto_giro, monto_excedente]
  end

  def self.dias_corridos_desde(fecha_inicio, fecha_fin)
    fecha_inicio = Date.parse(fecha_inicio) if fecha_inicio.is_a?(String)
    fecha_fin = Date.parse(fecha_fin) if fecha_fin.is_a?(String)
    (fecha_fin - fecha_inicio).to_i + 1
  end

  def self.format_number_with_delimiter(number)
    whole, decimal = number.to_s.split('.')
    whole_with_delimiter = whole.chars.to_a.reverse.each_slice(3).map(&:join).join('.').reverse
    [whole_with_delimiter, decimal].compact.join(',')
  end
end
