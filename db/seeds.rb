item_a = Item.create!(name: 'Celular Galaxy S21', description: 'Smartphone Samsung com 128GB de armazenamento',
                      weight: 171, width: 7, height: 15, depth: 1, category: 'Eletrônicos', image: { io: File.open(Rails.root.join('app', 'assets', 'images', '1.png')), filename: '1.png', content_type: 'image/png' })
item_b = Item.create!(name: 'Teclado Mecânico RGB', description: 'Teclado mecânico com iluminação RGB', weight: 800,
                      width: 35, height: 2, depth: 13, category: 'Periféricos')
item_c = Item.create!(name: 'Mochila para Notebook', description: 'Mochila resistente a água para notebooks até 15.6"',
                      weight: 900, width: 30, height: 45, depth: 15, category: 'Acessórios')
item_d = Item.create!(name: 'Notebook Gamer Acer Predator', description: 'Intel Core i7 16GB 512GB SSD RTX 3060 15.6"',
                      weight: 2500, width: 38, height: 2, depth: 26, category: 'Eletrônicos')
item_e = Item.create!(name: 'Cadeira Gamer Couro Sintético',
                      description: 'Cadeira Gamer Reclinável com apoio de braços ajustável', weight: 20_000, width: 70, height: 130, depth: 70, category: 'Acessórios')
item_f = Item.create!(name: 'Headset Gamer HyperX Cloud Alpha', description: 'Fone de Ouvido com Microfone, Preto',
                      weight: 336, width: 23, height: 20, depth: 12, category: 'Acessórios')
item_g = Item.create!(name: 'Mousepad Gamer Speed', description: 'Mousepad Gamer Speed com Base Antiderrapante',
                      weight: 500, width: 80, height: 1, depth: 30, category: 'Acessórios')
item_h = Item.create!(name: 'SSD Kingston A2000 NVMe M.2', description: '1TB, Leitura 2200MB/s, Gravação 2000MB/s',
                      weight: 8, width: 2, height: 1, depth: 8, category: 'Eletrônicos')
item_i = Item.create!(name: 'Console PlayStation 5', description: 'Console Sony PlayStation 5', weight: 3900,
                      width: 10, height: 39, depth: 26, category: 'Eletrônicos')
item_j = Item.create!(name: 'Console Xbox Series X', description: 'Console Microsoft Xbox Series X', weight: 4300,
                      width: 15, height: 30, depth: 15, category: 'Eletrônicos')
item_k = Item.create!(name: 'Monitor Gamer ASUS VG245H', description: 'Monitor Gamer LED 24" Full HD Widescreen',
                      weight: 5500, width: 57, height: 41, depth: 21, category: 'Eletrônicos')
item_l = Item.create!(name: 'Roteador Wi-Fi TP-Link Archer C6', description: 'Roteador Wireless Dual Band AC1200',
                      weight: 350, width: 14, height: 4, depth: 23, category: 'Eletrônicos')
item_m = Item.create!(name: 'Smart TV LED 43" Samsung', description: 'Smart TV Crystal UHD 4K 2020 TU7000',
                      weight: 8000, width: 96, height: 56, depth: 6, category: 'Eletrônicos')
item_n = Item.create!(name: 'Ar Condicionado Split Inverter 9000 BTUs',
                      description: 'Ar-Condicionado Split Inverter LG Dual Inverter', weight: 8500, width: 84, height: 31, depth: 19, category: 'Eletrodomésticos')
item_o = Item.create!(name: 'Refrigerador Frost Free 275L Electrolux',
                      description: 'Geladeira/Refrigerador Electrolux Branco', weight: 43_000, width: 60, height: 169, depth: 69, category: 'Eletrodomésticos')
item_p = Item.create!(name: 'Fogão 5 Bocas Consul', description: 'Fogão Consul 5 Bocas com Mesa de Vidro',
                      weight: 28_000, width: 76, height: 96, depth: 69, category: 'Eletrodomésticos')
item_q = Item.create!(name: 'Máquina de Lavar Brastemp 12kg', description: 'Máquina de Lavar Brastemp 12kg',
                      weight: 37_000, width: 62, height: 106, depth: 69, category: 'Eletrodomésticos')
item_r = Item.create!(name: 'Micro-ondas LG Easy Clean 30L', description: 'Micro-ondas LG Easy Clean 30L',
                      weight: 12_000, width: 50, height: 30, depth: 45, category: 'Eletrodomésticos')
item_s = Item.create!(name: 'Cafeteira Nespresso Essenza Mini', description: 'Cafeteira Nespresso Essenza Mini',
                      weight: 2200, width: 8, height: 20, depth: 33, category: 'Eletrodomésticos')
item_t = Item.create!(name: 'Bicicleta Caloi Aro 29', description: 'Bicicleta Caloi Aro 29 Velocidade', weight: 13_000,
                      width: 185, height: 105, depth: 20, category: 'Esportes')
item_u = Item.create!(name: 'Esteira Elétrica Athletic Advanced',
                      description: 'Esteira Elétrica Athletic Advanced 520EE', weight: 29_000, width: 70, height: 130, depth: 160, category: 'Esportes')
item_v = Item.create!(name: 'Banco de Musculação Kikos', description: 'Banco de Musculação Kikos Academia Residencial',
                      weight: 15_000, width: 180, height: 120, depth: 60, category: 'Esportes')
item_w = Item.create!(name: 'Violão Acústico Fender', description: 'Violão Fender Acústico Dreadnought', weight: 2300,
                      width: 40, height: 101, depth: 11, category: 'Instrumentos Musicais')
item_x = Item.create!(name: 'Piano Digital Yamaha P-125', description: 'Piano Digital Yamaha P-125', weight: 11_000,
                      width: 132, height: 16, depth: 29, category: 'Instrumentos Musicais')
item_y = Item.create!(name: 'Guitarra Ibanez RG450DX', description: 'Guitarra Elétrica Ibanez RG450DX', weight: 3300,
                      width: 32, height: 105, depth: 5, category: 'Instrumentos Musicais')
item_z = Item.create!(name: 'Bateria Acústica Mapex Prodigy', description: 'Bateria Acústica Mapex Prodigy',
                      weight: 40_000, width: 200, height: 100, depth: 200, category: 'Instrumentos Musicais')

# items = Item.order(:id)
# image_files = (1..26).map { |n| "#{n}.png" }

# items.zip(image_files).each do |item, image_file| # Trocado devido ao recorrente erro: ActiveRecord::StatementInvalid: SQLite3::BusyException: database is locked
#   item.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_file)), filename: image_file, content_type: 'image/png')
#   ActiveRecord::Base.connection.close # não resolveu o problema (SQLite3::BusyException: database is locked)
# end

# item_a.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '1.png')), filename: '1.png', content_type: 'image/png')
item_b.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '2.png')), filename: '2.png',
                    content_type: 'image/png')
item_c.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '3.png')), filename: '3.png',
                    content_type: 'image/png')
item_d.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '4.png')), filename: '4.png',
                    content_type: 'image/png')
item_e.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '5.png')), filename: '5.png',
                    content_type: 'image/png')
item_f.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '6.png')), filename: '6.png',
                    content_type: 'image/png')
item_g.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '7.png')), filename: '7.png',
                    content_type: 'image/png')
item_h.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '8.png')), filename: '8.png',
                    content_type: 'image/png')
item_i.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '9.png')), filename: '9.png',
                    content_type: 'image/png')
item_j.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '10.png')), filename: '10.png',
                    content_type: 'image/png')
item_k.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '11.png')), filename: '11.png',
                    content_type: 'image/png')
item_l.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '12.png')), filename: '12.png',
                    content_type: 'image/png')
item_m.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '13.png')), filename: '13.png',
                    content_type: 'image/png')
item_n.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '14.png')), filename: '14.png',
                    content_type: 'image/png')
item_o.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '15.png')), filename: '15.png',
                    content_type: 'image/png')
item_p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '16.png')), filename: '16.png',
                    content_type: 'image/png')
item_q.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '17.png')), filename: '17.png',
                    content_type: 'image/png')
item_r.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '18.png')), filename: '18.png',
                    content_type: 'image/png')
item_s.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '19.png')), filename: '19.png',
                    content_type: 'image/png')
item_t.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '20.png')), filename: '20.png',
                    content_type: 'image/png')
item_u.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '21.png')), filename: '21.png',
                    content_type: 'image/png')
item_v.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '22.png')), filename: '22.png',
                    content_type: 'image/png')
item_w.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '23.png')), filename: '23.png',
                    content_type: 'image/png')
item_x.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '24.png')), filename: '24.png',
                    content_type: 'image/png')
item_y.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '25.png')), filename: '25.png',
                    content_type: 'image/png')
item_z.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '26.png')), filename: '26.png',
                    content_type: 'image/png')

# #Criação de usuários e admins
password = 123456
user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password:, cpf: '42513565606')
user_b = User.create!(nickname: 'Joao', email: 'joao7@email.com.br', password:, cpf: '63833236442')
user_c = User.create!(nickname: 'Manoela', email: 'manu@email.com.br', password:, cpf: '59113983709')
user_d = User.create!(nickname: 'Darci', email: 'dada@email.com.br', password:, cpf: '56896226722')
user_e = User.create!(nickname: 'Lana', email: 'lang@email.com.br', password:, cpf: '44811903706')
user_f = User.create!(nickname: 'Renan', email: 'renan@campuscode.com.br', password:, cpf: '06871624163')

admin_a = User.create!(nickname: 'Ad_joao_cc', email: 'skywalker@leilaodogalpao.com.br', password:,
                       cpf: '56086147396')
admin_b = User.create!(nickname: 'Ad_debora', email: 'debs@leilaodogalpao.com.br', password:,
                       cpf: '25488078274')
admin_c = User.create!(nickname: 'Ad_bruna', email: 'bruh@leilaodogalpao.com.br', password:,
                       cpf: '31290135983')

# Valores padrão para lotes
minimum_bid = 200
minimum_bid_increment = 10

# 2 Lotes Futuros / 1 aguardando aprovação >> start_date: 3.hours.from_now, end_date: 3.days.from_now
start_date = 3.months.from_now
end_date = start_date + 3.weeks

# 1 Aguardando Aprovação
lot_a = Lot.create!(code: 'OPQ890567', start_date:, end_date:, minimum_bid:,
                    minimum_bid_increment:, creator: admin_a)
item_e.update(lot_id: lot_a.id)

# 2 Lotes Futuros (aprovados)
lot_b = Lot.create!(code: 'LMN789234', start_date:, end_date:, minimum_bid:,
                    minimum_bid_increment:, creator: admin_a)
item_f.update(lot_id: lot_b.id)
item_g.update(lot_id: lot_b.id)
lot_b.update(status: :approved, approver: admin_b)

lot_c = Lot.create!(code: 'IJK456012', start_date:, end_date:, minimum_bid:,
                    minimum_bid_increment:, creator: admin_a)
item_o.update(lot_id: lot_c.id)
item_p.update(lot_id: lot_c.id)
lot_c.update(status: :approved, approver: admin_b)

# 3 Lotes em andamento # start_date: 1.hour.ago, end_date: 3.days.from_now
start_date = 1.hour.ago
end_date = 3.months.from_now

lot_d = Lot.new(code: 'FGH123789', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_c)
lot_d.save(validate: false)
item_v.update(lot_id: lot_d.id)
item_u.update(lot_id: lot_d.id)
item_t.update(lot_id: lot_d.id)
lot_d.update(status: :approved, approver: admin_a)
lot_d.save(validate: false)

bid_a = Bid.new(amount: minimum_bid, user: user_a, lot: lot_d, created_at: start_date)
bid_a.save(validate: false)
bid_b = Bid.new(amount: minimum_bid + minimum_bid_increment, user: user_b, lot: lot_d, created_at: start_date)
bid_b.save(validate: false)
bid_c = Bid.new(amount: minimum_bid + (minimum_bid_increment * 2), user: user_e, lot: lot_d, created_at: start_date)
bid_c.save(validate: false)

lot_e = Lot.new(code: 'CDE890456', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_c)
lot_e.save(validate: false)
item_b.update(lot_id: lot_e.id)
item_c.update(lot_id: lot_e.id)
item_d.update(lot_id: lot_e.id)
lot_e.update(status: :approved, approver: admin_b)
lot_e.save(validate: false)

question_a = Question.new(lot: lot_e, user: user_d, content: 'Aceitam cheque?',
                          answer: 'Não aceitamos. Leia mais em nosso FAQ.', answered_by: admin_a, created_at: start_date, updated_at: start_date + 1.hour)
question_a.save(validate: false)

lot_f = Lot.new(code: 'ZAB567123', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_a)
lot_f.save(validate: false)
item_z.update(lot_id: lot_f.id)
item_y.update(lot_id: lot_f.id)
lot_f.update(status: :approved, approver: admin_b)
lot_f.save(validate: false)

bid_a = Bid.new(amount: minimum_bid + 50, user: user_c, lot: lot_f, created_at: start_date)
bid_a.save(validate: false)
bid_b = Bid.new(amount: minimum_bid + 50 + minimum_bid_increment, user: user_d, lot: lot_f, created_at: start_date)
bid_b.save(validate: false)
bid_c = Bid.new(amount: minimum_bid + 50 + (minimum_bid_increment * 2), user: user_f, lot: lot_f,
                created_at: start_date)
bid_c.save(validate: false)

question_a = Question.new(lot: lot_f, user: user_f, content: 'Oi João, olha eu aqui! :D',
                          created_at: start_date + 1.hour)
question_a.save(validate: false)

# Lotes encerrados >> start_date: 1.day.ago, end_date: 1.hour.ago
start_date = 1.week.ago
end_date = 1.hour.ago

# 1 Lote VENDIDO
lot_g = Lot.new(code: 'WXY234890', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_a)
lot_g.save(validate: false)
item_a.update(lot_id: lot_g.id)
lot_g.update(status: :sold, approver: admin_b)
lot_g.save(validate: false)

bid_a = Bid.new(amount: minimum_bid, user: user_a, lot: lot_g, created_at: start_date)
bid_a.save(validate: false)
bid_b = Bid.new(amount: minimum_bid + minimum_bid_increment, user: user_b, lot: lot_g, created_at: start_date)
bid_b.save(validate: false)

question_a = Question.new(lot: lot_g, user: user_d, content: 'Muito barato. Tá funcionando?',
                          answer: 'Está sim, apenas com um risco na tela', answered_by: admin_c, created_at: start_date, updated_at: start_date + 1.hour)
question_a.save(validate: false)

# 1 Lote CANCELADO
lot_h = Lot.new(code: 'TUV012789', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_a)
lot_h.save(validate: false)
lot_h.update(status: :canceled, approver: admin_b)
lot_h.save(validate: false)

# 2 Lotes aguardando VALIDAÇÃO - 1 Venda, 1 Cancelado
lot_i = Lot.new(code: 'QRS789456', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_c)
lot_i.save(validate: false)
item_x.update(lot_id: lot_i.id)
item_w.update(lot_id: lot_i.id)
lot_i.update(status: :approved, approver: admin_b)
lot_i.save(validate: false)

bid_a = Bid.new(amount: minimum_bid + 50, user: user_c, lot: lot_i, created_at: start_date)
bid_a.save(validate: false)
bid_b = Bid.new(amount: minimum_bid + 50 + minimum_bid_increment, user: user_d, lot: lot_i, created_at: start_date)
bid_b.save(validate: false)

lot_j = Lot.new(code: 'NOP456123', start_date:, end_date:, minimum_bid:,
                minimum_bid_increment:, creator: admin_c)
lot_j.save(validate: false)
item_s.update(lot_id: lot_j.id)
item_r.update(lot_id: lot_j.id)
lot_j.update(status: :approved, approver: admin_b)
lot_j.save(validate: false)
