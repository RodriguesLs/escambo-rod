module Backoffice::AdminsHelper

  OptionsForRole = Struct.new(:id, :description)

    def options_for_role
      Admin.roles_i18n.map do |key, value|
        OptionsForRole.new(key, value)
    end
  end

end