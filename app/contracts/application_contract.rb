# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n
  config.messages.top_namespace = "contract_errors"
  config.messages.load_paths += %w[config/locales/contract_errors.es.yml config/locales/contract_errors.en.yml]
end
