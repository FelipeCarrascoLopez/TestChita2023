require 'sinatra'
require_relative 'api_client'
require_relative 'calculator'

get '/' do
  erb :form
end

post '/submit' do
  client_dni = params[:client_dni]
  debtor_dni = params[:debtor_dni]
  document_amount = params[:document_amount]
  folio = params[:folio]
  expiration_date = params[:expiration_date]
  fecha_formulario = Date.today.to_s
  #ASD
  @api_response = APIClient.get_api_response(client_dni, debtor_dni, document_amount, folio, expiration_date)
  @amounts = Calculator.amounts(@api_response, document_amount.to_i, expiration_date, fecha_formulario)
  #Resultado
  erb :result
end
