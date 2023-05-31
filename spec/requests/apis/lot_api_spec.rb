require 'rails_helper'

describe "Lot API" do
  context "GET /api/v1/lots/1" do
    it "success" do
      ##
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      lot_a = Lot.create!(code: 'XYZ123456', start_date: Time.now + 1.day, end_date: Time.now + 7.days, minimum_bid: 100.0, minimum_bid_increment: 10.0, creator: admin_a)
      item_a = Item.create!(lot_id: lot_a.id, name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      lot_a.update(status: :approved, approver: admin_b)

      ##
      get "/api/v1/lots/#{lot_a.id}"

      ##
      expect(response.status).to  eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["code"]).to eq 'XYZ123456'
      expect(json_response["id"]).to eq lot_a.id
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
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_a = Item.create!(lot_id: lot_a.id, name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      lot_a.update(status: :approved, approver: admin_b)
      
      lot_b = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_b = Item.create!(lot_id: lot_b.id, name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      lot_b.update(status: :approved, approver: admin_b)

      ##
      get "/api/v1/lots"

      ##
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response[0]["code"]).to eq 'ABC123456'
      expect(json_response[1]["code"]).to eq 'XYZ123456'
    end

    it "fails due to internal error" do
      ##
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_a = Item.create!(lot_id: lot_a.id, name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      lot_a.update(status: :approved, approver: admin_b)
      
      lot_b = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_b = Item.create!(lot_id: lot_b.id, name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      lot_b.update(status: :approved, approver: admin_b)

      ##
      get "/api/v1/lots"

      ##
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response[0]["code"]).to eq 'ABC123456'
      expect(json_response[1]["code"]).to eq 'XYZ123456'
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
    end
    
  end

  context "POST /api/v1/lots" do
    it "success" do
      ##
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      lot_params = {lot: {code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator_id: admin_a.id}}

      ##
      post "/api/v1/lots", params: lot_params
      ##
      expect(response.status).to eq 201
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["code"]).to eq lot_params[:lot][:code]
      expect(DateTime.parse(json_response["start_date"]).iso8601).to eq lot_params[:lot][:start_date].iso8601
      expect(DateTime.parse(json_response["end_date"]).iso8601).to eq lot_params[:lot][:end_date].iso8601
      expect(json_response["minimum_bid"].to_f).to eq lot_params[:lot][:minimum_bid].to_f
      expect(json_response["minimum_bid_increment"].to_f).to eq lot_params[:lot][:minimum_bid_increment].to_f
      expect(json_response["creator_id"]).to eq lot_params[:lot][:creator_id]
      
      expect(json_response["status"]).to eq "pending_approval"
      expect(json_response["approver_id"]).to eq nil
    end

    it "fails if incomplete" do
      ##
      lot_params = {lot: {code: 'XYZ123456'}}
      
      ##
      post "/api/v1/lots", params: lot_params
      
      ##
      expect(response.status).to eq 412
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["errors"]).to_not include 'Código não pode ficar em branco'
      expect(json_response["errors"]).to_not include 'Código Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)'
      expect(json_response["errors"]).to include 'Criador é obrigatório(a)'
      expect(json_response["errors"]).to include 'Criador deve ser um administrador'
      expect(json_response["errors"]).to include 'Lance mínimo não pode ficar em branco'
      expect(json_response["errors"]).to include 'Lance mínimo não é um número'
      expect(json_response["errors"]).to include 'Incremento mínimo não pode ficar em branco'
      expect(json_response["errors"]).to include 'Incremento mínimo não é um número'
      expect(json_response["errors"]).to include 'Data de início não pode ficar em branco'
      expect(json_response["errors"]).to include 'Data de término não pode ficar em branco'
    end
    
    it "fails due to internal error" do
      ##
      allow(Lot).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      lot_params = {lot: {code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator_id: admin_a.id}}

      ##
      post "/api/v1/lots", params: lot_params
      
      ##
      expect(response.status).to eq 500
    end
    
  end
  
  
end
