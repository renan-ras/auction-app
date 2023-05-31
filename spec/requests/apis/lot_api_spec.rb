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

    it "fail" do
      ##
      ##
      get "/api/v1/lots/999999"

      ##
      expect(response.status).to  eq 404
    end
    
  end

  context "GET /api/v1/lots" do
    it "in code order" do
      ##
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      lot_b = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)

      ##
      get "/api/v1/lots"

      ##
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response[0]["code"]).to eq 'ABC123456'
      expect(json_response[1]["code"]).to eq 'XYZ123456'
      # expect(json_response).to include 'banana'
    end

    it "empty" do
      ##

      ##
      get "/api/v1/lots"

      ##
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response).to eq []
      # expect(json_response).to include 'banana'
    end
    
    
  end
  
end
