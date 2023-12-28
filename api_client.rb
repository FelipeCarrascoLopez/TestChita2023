require 'net/http'
require 'uri'
require 'json'

module APIClient
  def self.get_api_response(client_dni, debtor_dni, document_amount, folio, expiration_date)
    url = URI("https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{client_dni}&debtor_dni=#{debtor_dni}&document_amount=#{document_amount}&folio=#{folio}&expiration_date=#{expiration_date}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(url)
    request["X-Api-Key"] = "pZX5rN8qAdgzCe0cAwpnQQtt"

    response = http.request(request)
    JSON.parse(response.body)
  rescue => e
    "Error: #{e.message}"
  end
end
