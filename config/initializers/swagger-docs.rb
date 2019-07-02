include Swagger::Docs::ImpotentMethods

# Swagger::Docs::Config.register_apis({})

class Swagger::Docs::Config
  def self.base_api_controller
    ActionController::API 
  end
end