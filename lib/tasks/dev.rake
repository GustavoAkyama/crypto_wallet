namespace :dev do

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?

      show_spinner("Apagando BD") {%x(rails db:drop)}
      show_spinner("Criando BD") {%x(rails db:create)}
      show_spinner("Migrando BD") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
      
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end

  end


  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
                  {
                      description: "Bitcoin",
                      acronym: "BTC",
                      url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1.png",
                      mining_type: MiningType.find_by(acronym: 'PoW')
                  },
                  {
                      description: "Ethereum",
                      acronym: "ETH",
                      url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png",
                      mining_type: MiningType.find_by(acronym: 'PoW')
                  },
                  {
                      description: "BNB",
                      acronym: "BNB",
                      url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1839.png",
                      mining_type: MiningType.find_by(acronym: '#')
                  },
                  {
                      description: "TRON",
                      acronym: "TRX",
                      url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1958.png",
                      mining_type: MiningType.find_by(acronym: '#')
                  }
              ]

      coins.each do |coin|
          Coin.find_or_create_by!(coin)
      end
    end
  end


  desc "Cadastro dos tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {
            description: "Proof of Work",
            acronym: "PoW"
        },
        {
            description: "Proof of Stake",
            acronym: "PoS"
        },
        {
            description: "Not Mineable",
            acronym: "#"
        }
      ]

      mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type)
      end
    end
  end


  private

  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}...", format: :pulse_2)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end

end
