require 'rails_helper'

describe "Lot API" do
  context "GET /api/v1/lots/1" do
    it "success" do
      ##
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      lot_a = Lot.create!(code: 'XYZ123456', start_date: Time.now + 1.day, end_date: Time.now + 7.days, minimum_bid: 100.0, minimum_bid_increment: 10.0, creator: admin_a)

      ##
      get "/api/v1/lots/#{lot_a.id}"

      ##
      expect(response.status).to  eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["code"]).to eq 'XYZ123456'
      expect(json_response["id"]).to eq lot_a.id
      # expect(json_response).to include 'banana'
    end
  end
end
