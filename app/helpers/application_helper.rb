module ApplicationHelper

    def locale
      I18n.locale == :en ? "English - USA" : "Português - BR"
    end

    def date_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end

    def name_application
        "Crypto Wallet APP"
    end

    def environment_rails

        case Rails.env
        when "development"
          "Desenvolvimento"
        when "production"
          "Produção"
        else
          "Teste"
        end
      
    end

end
